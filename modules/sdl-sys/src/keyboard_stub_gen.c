// Generated file. Do not edit by hand.

#include <SDL3/SDL_keyboard.h>
#include <moonbit.h>
#include <stdint.h>

SDL_Window *moonbit_sdl_window_ptr(void *self);

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_start_text_input(void * window) {
  return SDL_StartTextInput(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_stop_text_input(void * window) {
  return SDL_StopTextInput(moonbit_sdl_window_ptr(window));
}
