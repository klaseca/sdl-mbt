#include <SDL3/SDL.h>
#include <moonbit.h>
#include <stdint.h>
#include <string.h>

typedef void (*moonbit_sdl_event_watch_call_callback_t)(void *, moonbit_bytes_t);

typedef struct moonbit_sdl_pending_event {
  struct moonbit_sdl_pending_event *next;
  uintptr_t watch_id;
  SDL_Event event;
  unsigned char payload[];
} moonbit_sdl_pending_event_t;

typedef struct moonbit_sdl_event_watch {
  moonbit_sdl_event_watch_call_callback_t call_callback;
  void *callback;
  int active;
  uintptr_t id;
  struct moonbit_sdl_event_watch *next;
} moonbit_sdl_event_watch_t;

// Only the main thread reads the weak registry. Pending records carry unique IDs
// instead of MoonBit references. One queue preserves order across all listeners.
static moonbit_sdl_event_watch_t *moonbit_sdl_event_watches = NULL;
static uintptr_t moonbit_sdl_next_watch_id = 1;
static SDL_Mutex *moonbit_sdl_pending_lock = NULL;
static moonbit_sdl_pending_event_t *moonbit_sdl_pending_head = NULL;
static moonbit_sdl_pending_event_t *moonbit_sdl_pending_tail = NULL;
static int moonbit_sdl_pending_scheduled = 0;

typedef struct {
  const char *first;
  const char *second;
  const char *const *list;
  int count;
} moonbit_sdl_event_payload_t;

static moonbit_sdl_event_payload_t moonbit_sdl_event_payload(const SDL_Event *event) {
  moonbit_sdl_event_payload_t payload = {0};
  switch (event->type) {
  case SDL_EVENT_TEXT_INPUT:
    payload.first = event->text.text;
    break;
  case SDL_EVENT_TEXT_EDITING:
    payload.first = event->edit.text;
    break;
  case SDL_EVENT_TEXT_EDITING_CANDIDATES:
    payload.list = event->edit_candidates.candidates;
    payload.count = event->edit_candidates.num_candidates;
    break;
  case SDL_EVENT_DROP_BEGIN:
  case SDL_EVENT_DROP_FILE:
  case SDL_EVENT_DROP_TEXT:
  case SDL_EVENT_DROP_COMPLETE:
  case SDL_EVENT_DROP_POSITION:
    payload.first = event->drop.source;
    payload.second = event->drop.data;
    break;
  case SDL_EVENT_CLIPBOARD_UPDATE:
    payload.list = event->clipboard.mime_types;
    payload.count = event->clipboard.num_mime_types;
    break;
  default:
    break;
  }
  if (payload.list == NULL || payload.count < 0) payload.count = 0;
  return payload;
}

static size_t moonbit_sdl_event_payload_size(moonbit_sdl_event_payload_t payload) {
  size_t size = (size_t)payload.count * sizeof(char *);
  if (payload.first != NULL) size += strlen(payload.first) + 1;
  if (payload.second != NULL) size += strlen(payload.second) + 1;
  for (int i = 0; i < payload.count; ++i) {
    if (payload.list[i] != NULL) size += strlen(payload.list[i]) + 1;
  }
  return size;
}

static const char *moonbit_sdl_copy_event_string(char **next, const char *source) {
  if (source == NULL) return NULL;
  size_t size = strlen(source) + 1;
  char *result = *next;
  memcpy(result, source, size);
  *next += size;
  return result;
}

// Queued C storage and MoonBit Bytes own copies of SDL's temporary strings.
// Native Bytes do not move, so pointers remain valid while the Bytes are retained.
static void moonbit_sdl_copy_event(SDL_Event *target, const SDL_Event *source,
                                   moonbit_sdl_event_payload_t payload) {
  memcpy(target, source, sizeof(*target));
  char **list = (char **)((unsigned char *)target + sizeof(*target));
  char *next = (char *)(list + payload.count);
  const char *first = moonbit_sdl_copy_event_string(&next, payload.first);
  const char *second = moonbit_sdl_copy_event_string(&next, payload.second);
  for (int i = 0; i < payload.count; ++i) {
    list[i] = (char *)moonbit_sdl_copy_event_string(&next, payload.list[i]);
  }
  switch (source->type) {
  case SDL_EVENT_TEXT_INPUT: target->text.text = first; break;
  case SDL_EVENT_TEXT_EDITING: target->edit.text = first; break;
  case SDL_EVENT_TEXT_EDITING_CANDIDATES:
    target->edit_candidates.candidates = payload.count ? (const char *const *)list : NULL;
    break;
  case SDL_EVENT_DROP_BEGIN:
  case SDL_EVENT_DROP_FILE:
  case SDL_EVENT_DROP_TEXT:
  case SDL_EVENT_DROP_COMPLETE:
  case SDL_EVENT_DROP_POSITION:
    target->drop.source = first;
    target->drop.data = second;
    break;
  case SDL_EVENT_CLIPBOARD_UPDATE:
    target->clipboard.mime_types = payload.count ? (const char **)list : NULL;
    break;
  default: break;
  }
}

static void moonbit_sdl_free_pending_events(moonbit_sdl_pending_event_t *event) {
  while (event != NULL) {
    moonbit_sdl_pending_event_t *next = event->next;
    SDL_free(event);
    event = next;
  }
}

static void moonbit_sdl_deliver_event(moonbit_sdl_event_watch_t *watch,
                                     const SDL_Event *event) {
  if (!watch->active || watch->callback == NULL) return;
  moonbit_sdl_event_payload_t payload = moonbit_sdl_event_payload(event);
  moonbit_bytes_t bytes = moonbit_make_bytes(
    sizeof(SDL_Event) + moonbit_sdl_event_payload_size(payload), 0
  );
  moonbit_sdl_copy_event((SDL_Event *)bytes, event, payload);
  void *callback = watch->callback;
  // A callback may dispose itself or release its last MoonBit listener handle.
  moonbit_incref(callback);
  watch->call_callback(callback, bytes);
  moonbit_decref(callback);
  moonbit_decref(bytes);
}

static void SDLCALL moonbit_sdl_dispatch_pending_events(void *userdata) {
  (void)userdata;
  if (!SDL_IsMainThread()) return;
  while (moonbit_sdl_pending_lock != NULL) {
    // Keep unprocessed records visible to removal and recursive dispatch. A
    // callback can generate an event; it must follow all earlier queued calls.
    SDL_LockMutex(moonbit_sdl_pending_lock);
    moonbit_sdl_pending_event_t *event = moonbit_sdl_pending_head;
    if (event != NULL) {
      moonbit_sdl_pending_head = event->next;
      if (moonbit_sdl_pending_head == NULL) moonbit_sdl_pending_tail = NULL;
    } else {
      moonbit_sdl_pending_scheduled = 0;
    }
    SDL_UnlockMutex(moonbit_sdl_pending_lock);
    if (event == NULL) return;
    moonbit_sdl_event_watch_t *watch = moonbit_sdl_event_watches;
    while (watch != NULL && watch->id != event->watch_id) watch = watch->next;
    if (watch != NULL) {
      moonbit_incref(watch);
      moonbit_sdl_deliver_event(watch, &event->event);
      moonbit_decref(watch);
    }
    SDL_free(event);
  }
}

static bool SDLCALL moonbit_sdl_event_watch_filter(void *userdata, SDL_Event *event) {
  moonbit_sdl_event_watch_t *watch = (moonbit_sdl_event_watch_t *)userdata;
  if (event == NULL) return true;
  if (SDL_IsMainThread()) {
    moonbit_incref(watch);
    // Foreground events follow earlier queued callbacks across all listeners.
    moonbit_sdl_dispatch_pending_events(NULL);
    moonbit_sdl_deliver_event(watch, event);
    moonbit_decref(watch);
    return true;
  }

  // No MoonBit allocation, callback, or reference count operation on this path.
  // SDL serializes watch removal with in-flight filter calls.
  moonbit_sdl_event_payload_t payload = moonbit_sdl_event_payload(event);
  moonbit_sdl_pending_event_t *pending = SDL_malloc(
    sizeof(*pending) + moonbit_sdl_event_payload_size(payload)
  );
  if (pending == NULL) return true;
  pending->next = NULL;
  pending->watch_id = watch->id;
  moonbit_sdl_copy_event(&pending->event, event, payload);
  SDL_LockMutex(moonbit_sdl_pending_lock);
  if (moonbit_sdl_pending_tail != NULL) moonbit_sdl_pending_tail->next = pending;
  else moonbit_sdl_pending_head = pending;
  moonbit_sdl_pending_tail = pending;
  if (!moonbit_sdl_pending_scheduled) {
    moonbit_sdl_pending_scheduled = 1;
    if (!SDL_RunOnMainThread(moonbit_sdl_dispatch_pending_events, NULL, false)) {
      moonbit_sdl_free_pending_events(moonbit_sdl_pending_head);
      moonbit_sdl_pending_head = moonbit_sdl_pending_tail = NULL;
      moonbit_sdl_pending_scheduled = 0;
    }
  }
  SDL_UnlockMutex(moonbit_sdl_pending_lock);
  return true;
}

static void moonbit_sdl_event_watch_destroy(void *self) {
  moonbit_sdl_event_watch_t *watch = (moonbit_sdl_event_watch_t *)self;
  if (watch->active) {
    SDL_RemoveEventWatch(moonbit_sdl_event_watch_filter, watch);
    watch->active = 0;
    moonbit_sdl_event_watch_t **entry = &moonbit_sdl_event_watches;
    while (*entry != NULL && *entry != watch) entry = &(*entry)->next;
    if (*entry == watch) *entry = watch->next;
  }
  if (moonbit_sdl_pending_lock != NULL) {
    SDL_LockMutex(moonbit_sdl_pending_lock);
    moonbit_sdl_pending_event_t **entry = &moonbit_sdl_pending_head;
    moonbit_sdl_pending_tail = NULL;
    while (*entry != NULL) {
      moonbit_sdl_pending_event_t *event = *entry;
      if (event->watch_id == watch->id) {
        *entry = event->next;
        SDL_free(event);
      } else {
        moonbit_sdl_pending_tail = event;
        entry = &event->next;
      }
    }
    SDL_UnlockMutex(moonbit_sdl_pending_lock);
    if (moonbit_sdl_event_watches == NULL) {
      SDL_DestroyMutex(moonbit_sdl_pending_lock);
      moonbit_sdl_pending_lock = NULL;
      moonbit_sdl_pending_scheduled = 0;
    }
  }
  void *callback = watch->callback;
  watch->callback = NULL;
  if (callback != NULL) moonbit_decref(callback);
}

MOONBIT_FFI_EXPORT
moonbit_sdl_event_watch_t *moonbit_sdl_add_event_watch(
  moonbit_sdl_event_watch_call_callback_t call_callback, void *callback
) {
  moonbit_sdl_event_watch_t *watch = moonbit_make_external_object(
    moonbit_sdl_event_watch_destroy, sizeof(*watch)
  );
  memset(watch, 0, sizeof(*watch));
  watch->call_callback = call_callback;
  watch->callback = callback;
  if (!SDL_IsMainThread() || !SDL_WasInit(SDL_INIT_EVENTS)) {
    SDL_SetError("MoonBit event watches require SDL events initialized on the main thread");
    moonbit_sdl_event_watch_destroy(watch);
    return watch;
  }
  if (callback == NULL || call_callback == NULL || moonbit_sdl_next_watch_id == 0) {
    SDL_SetError("Invalid MoonBit event watch callback or exhausted listener IDs");
    moonbit_sdl_event_watch_destroy(watch);
    return watch;
  }
  if (moonbit_sdl_pending_lock == NULL) {
    moonbit_sdl_pending_lock = SDL_CreateMutex();
    if (moonbit_sdl_pending_lock == NULL) {
      moonbit_sdl_event_watch_destroy(watch);
      return watch;
    }
  }
  watch->id = moonbit_sdl_next_watch_id++;
  watch->active = 1;
  if (!SDL_AddEventWatch(moonbit_sdl_event_watch_filter, watch)) {
    watch->active = 0;
    moonbit_sdl_event_watch_destroy(watch);
    return watch;
  }
  watch->next = moonbit_sdl_event_watches;
  moonbit_sdl_event_watches = watch;
  return watch;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_event_watch_is_null(moonbit_sdl_event_watch_t *watch) {
  return watch == NULL || !watch->active;
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_remove_event_watch(moonbit_sdl_event_watch_t *watch) {
  moonbit_sdl_event_watch_destroy(watch);
}
