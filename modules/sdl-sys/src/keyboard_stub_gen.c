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

int32_t moonbit_sdl_start_text_input(moonbit_sdl_window_resource_t * window) {
  return SDL_StartTextInput(moonbit_sdl_window_ptr(window));
}

int32_t moonbit_sdl_stop_text_input(moonbit_sdl_window_resource_t * window) {
  return SDL_StopTextInput(moonbit_sdl_window_ptr(window));
}
