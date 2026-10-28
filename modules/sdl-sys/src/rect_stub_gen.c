// Generated file. Do not edit by hand.

#include <SDL3/SDL_rect.h>
#include <moonbit.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_rect_make(int32_t arg_x, int32_t arg_y, int32_t arg_w, int32_t arg_h) {
  SDL_Rect value = { 0 };
  value.x = arg_x;
  value.y = arg_y;
  value.w = arg_w;
  value.h = arg_h;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_Rect), 0);
  memcpy(bytes, &value, sizeof(SDL_Rect));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t *moonbit_sdl_rect_layout(void) {
  static const int32_t layout[] = {
    (int32_t)sizeof(SDL_Rect),
    (int32_t)offsetof(SDL_Rect, x),
    (int32_t)sizeof(((SDL_Rect *)0)->x),
    ((int)-1 < (int)0),
    (int32_t)offsetof(SDL_Rect, y),
    (int32_t)sizeof(((SDL_Rect *)0)->y),
    ((int)-1 < (int)0),
    (int32_t)offsetof(SDL_Rect, w),
    (int32_t)sizeof(((SDL_Rect *)0)->w),
    ((int)-1 < (int)0),
    (int32_t)offsetof(SDL_Rect, h),
    (int32_t)sizeof(((SDL_Rect *)0)->h),
    ((int)-1 < (int)0),
  };
  int32_t *result = moonbit_make_int32_array(13, 0);
  memcpy(result, layout, sizeof(layout));
  return result;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_frect_make(float arg_x, float arg_y, float arg_w, float arg_h) {
  SDL_FRect value = { 0 };
  value.x = arg_x;
  value.y = arg_y;
  value.w = arg_w;
  value.h = arg_h;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_FRect), 0);
  memcpy(bytes, &value, sizeof(SDL_FRect));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t *moonbit_sdl_frect_layout(void) {
  static const int32_t layout[] = {
    (int32_t)sizeof(SDL_FRect),
    (int32_t)offsetof(SDL_FRect, x),
    (int32_t)sizeof(((SDL_FRect *)0)->x),
    0,
    (int32_t)offsetof(SDL_FRect, y),
    (int32_t)sizeof(((SDL_FRect *)0)->y),
    0,
    (int32_t)offsetof(SDL_FRect, w),
    (int32_t)sizeof(((SDL_FRect *)0)->w),
    0,
    (int32_t)offsetof(SDL_FRect, h),
    (int32_t)sizeof(((SDL_FRect *)0)->h),
    0,
  };
  int32_t *result = moonbit_make_int32_array(13, 0);
  memcpy(result, layout, sizeof(layout));
  return result;
}
