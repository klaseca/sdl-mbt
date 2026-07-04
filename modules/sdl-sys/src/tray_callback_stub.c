#include "../../../externals/SDL/include/SDL3/SDL.h"
#include <moonbit.h>
#include <string.h>

typedef void (*moonbit_sdl_tray_entry_call_callback_t)(void *);

typedef struct {
  moonbit_sdl_tray_entry_call_callback_t call_callback;
  void *callback;
} moonbit_sdl_tray_entry_callback_t;

static void moonbit_sdl_tray_entry_callback_destroy(void *self) {
  moonbit_sdl_tray_entry_callback_t *holder = (moonbit_sdl_tray_entry_callback_t *)self;
  if (holder->callback != NULL) {
    moonbit_decref(holder->callback);
    holder->callback = NULL;
  }
}

static void moonbit_sdl_tray_entry_callback_trampoline(void *userdata, SDL_TrayEntry *entry) {
  (void)entry;
  moonbit_sdl_tray_entry_callback_t *holder = (moonbit_sdl_tray_entry_callback_t *)userdata;
  if (holder != NULL && holder->call_callback != NULL && holder->callback != NULL) {
    moonbit_incref(holder);
    holder->call_callback(holder->callback);
    moonbit_decref(holder);
  }
}

MOONBIT_FFI_EXPORT
moonbit_sdl_tray_entry_callback_t *moonbit_sdl_tray_entry_callback_make(
  moonbit_sdl_tray_entry_call_callback_t call_callback,
  void *callback
) {
  moonbit_sdl_tray_entry_callback_t *holder =
    (moonbit_sdl_tray_entry_callback_t *)moonbit_make_external_object(
      moonbit_sdl_tray_entry_callback_destroy,
      sizeof(moonbit_sdl_tray_entry_callback_t)
    );
  memset(holder, 0, sizeof(moonbit_sdl_tray_entry_callback_t));
  holder->call_callback = call_callback;
  holder->callback = callback;
  return holder;
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_set_tray_entry_callback(
  SDL_TrayEntry *entry,
  moonbit_sdl_tray_entry_callback_t *callback
) {
  SDL_SetTrayEntryCallback(
    entry,
    callback == NULL ? NULL : moonbit_sdl_tray_entry_callback_trampoline,
    callback
  );
}
