#include "../../../externals/SDL/include/SDL3/SDL.h"
#include <moonbit.h>
#include <stdint.h>
#include <string.h>

typedef void (*moonbit_sdl_event_watch_call_callback_t)(void *, moonbit_bytes_t);

static moonbit_sdl_event_watch_call_callback_t moonbit_sdl_event_watch_call_callback = NULL;

typedef struct {
  void *callback;
  int active;
} moonbit_sdl_event_watch_t;

static bool moonbit_sdl_event_watch_filter(void *userdata, SDL_Event *event) {
  moonbit_sdl_event_watch_t *watch = (moonbit_sdl_event_watch_t *)userdata;
  if (
    moonbit_sdl_event_watch_call_callback == NULL ||
    watch == NULL ||
    !watch->active ||
    watch->callback == NULL ||
    event == NULL
  ) {
    return true;
  }

  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_Event), 0);
  memcpy(bytes, event, sizeof(SDL_Event));
  moonbit_incref(watch->callback);
  moonbit_sdl_event_watch_call_callback(watch->callback, bytes);
  moonbit_decref(watch->callback);
  moonbit_decref(bytes);
  return true;
}

static void moonbit_sdl_event_watch_destroy(void *self) {
  moonbit_sdl_event_watch_t *watch = (moonbit_sdl_event_watch_t *)self;
  if (watch == NULL) {
    return;
  }
  if (watch->active) {
    SDL_RemoveEventWatch(moonbit_sdl_event_watch_filter, watch);
    watch->active = 0;
  }
  if (watch->callback != NULL) {
    moonbit_decref(watch->callback);
    watch->callback = NULL;
  }
}

MOONBIT_FFI_EXPORT
moonbit_sdl_event_watch_t *moonbit_sdl_add_event_watch(
  moonbit_sdl_event_watch_call_callback_t call_callback,
  void *callback
) {
  moonbit_sdl_event_watch_t *watch =
    (moonbit_sdl_event_watch_t *)moonbit_make_external_object(
      moonbit_sdl_event_watch_destroy,
      sizeof(moonbit_sdl_event_watch_t)
    );
  watch->callback = NULL;
  watch->active = 0;
  moonbit_sdl_event_watch_call_callback = call_callback;

  if (callback == NULL) {
    return watch;
  }

  watch->callback = callback;
  if (!SDL_AddEventWatch(moonbit_sdl_event_watch_filter, watch)) {
    moonbit_decref(callback);
    watch->callback = NULL;
    return watch;
  }
  watch->active = 1;
  return watch;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_event_watch_is_null(moonbit_sdl_event_watch_t *watch) {
  return watch == NULL || !watch->active || watch->callback == NULL;
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_remove_event_watch(moonbit_sdl_event_watch_t *watch) {
  moonbit_sdl_event_watch_destroy(watch);
}
