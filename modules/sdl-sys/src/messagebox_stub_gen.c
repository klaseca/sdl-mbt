// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL.h"
#include <moonbit.h>
#include <stddef.h>
#include <stdint.h>

typedef struct {
  SDL_Window *ptr;
} moonbit_sdl_window_resource_t;

static SDL_Window *moonbit_sdl_window_ptr(moonbit_sdl_window_resource_t *self) {
  return self == NULL ? NULL : self->ptr;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_show_simple_message_box(SDL_MessageBoxFlags flags, moonbit_bytes_t title, moonbit_bytes_t message, moonbit_sdl_window_resource_t * window) {
  return SDL_ShowSimpleMessageBox(flags, (const char *)title, (const char *)message, moonbit_sdl_window_ptr(window));
}
