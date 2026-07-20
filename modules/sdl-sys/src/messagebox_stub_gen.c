// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL_messagebox.h"
#include <moonbit.h>
#include <stdint.h>

SDL_Window *moonbit_sdl_window_ptr(void *self);

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_show_simple_message_box(SDL_MessageBoxFlags flags, moonbit_bytes_t title, moonbit_bytes_t message, void * window) {
  return SDL_ShowSimpleMessageBox(flags, (const char *)title, (const char *)message, moonbit_sdl_window_ptr(window));
}
