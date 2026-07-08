// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL.h"
#include <moonbit.h>
#include <string.h>

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_f_rect_make(float x, float y, float w, float h) {
  SDL_FRect value = { 0 };
  value.x = x;
  value.y = y;
  value.w = w;
  value.h = h;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_FRect), 0);
  memcpy(bytes, &value, sizeof(SDL_FRect));
  return bytes;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_rect_make(int x, int y, int w, int h) {
  SDL_Rect value = { 0 };
  value.x = x;
  value.y = y;
  value.w = w;
  value.h = h;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_Rect), 0);
  memcpy(bytes, &value, sizeof(SDL_Rect));
  return bytes;
}
