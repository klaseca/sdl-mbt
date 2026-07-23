// Generated file. Do not edit by hand.

#include <SDL3/SDL_rect.h>
#include <moonbit.h>
#include <stdint.h>
#include <string.h>

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_rect_make(int32_t x, int32_t y, int32_t w, int32_t h) {
  SDL_Rect value = { 0 };
  value.x = x;
  value.y = y;
  value.w = w;
  value.h = h;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_Rect), 0);
  memcpy(bytes, &value, sizeof(SDL_Rect));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_rect_x(moonbit_bytes_t self) {
  return ((SDL_Rect *)self)->x;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_rect_y(moonbit_bytes_t self) {
  return ((SDL_Rect *)self)->y;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_rect_w(moonbit_bytes_t self) {
  return ((SDL_Rect *)self)->w;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_rect_h(moonbit_bytes_t self) {
  return ((SDL_Rect *)self)->h;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_frect_make(float x, float y, float w, float h) {
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
float moonbit_sdl_frect_x(moonbit_bytes_t self) {
  return ((SDL_FRect *)self)->x;
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_frect_y(moonbit_bytes_t self) {
  return ((SDL_FRect *)self)->y;
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_frect_w(moonbit_bytes_t self) {
  return ((SDL_FRect *)self)->w;
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_frect_h(moonbit_bytes_t self) {
  return ((SDL_FRect *)self)->h;
}
