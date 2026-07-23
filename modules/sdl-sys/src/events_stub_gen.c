// Generated file. Do not edit by hand.

#include <SDL3/SDL_events.h>
#include <moonbit.h>
#include <stdint.h>
#include <string.h>

moonbit_bytes_t moonbit_cstring_to_bytes_sdl(const char *str);

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_event_make(void) {
  SDL_Event value = { 0 };
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_Event), 0);
  memcpy(bytes, &value, sizeof(SDL_Event));
  return bytes;
}

MOONBIT_FFI_EXPORT
Uint32 moonbit_sdl_event_event_type(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->type;
}

MOONBIT_FFI_EXPORT
SDL_WindowID moonbit_sdl_event_key_window_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.windowID;
}

MOONBIT_FFI_EXPORT
SDL_KeyboardID moonbit_sdl_event_key_keyboard_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.which;
}

MOONBIT_FFI_EXPORT
SDL_Scancode moonbit_sdl_event_key_scancode(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.scancode;
}

MOONBIT_FFI_EXPORT
SDL_Keycode moonbit_sdl_event_key_keycode(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.key;
}

MOONBIT_FFI_EXPORT
SDL_Keymod moonbit_sdl_event_key_modifiers(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.mod;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_event_key_repeat(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.repeat;
}

MOONBIT_FFI_EXPORT
SDL_WindowID moonbit_sdl_event_motion_window_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.windowID;
}

MOONBIT_FFI_EXPORT
SDL_MouseID moonbit_sdl_event_motion_mouse_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.which;
}

MOONBIT_FFI_EXPORT
SDL_MouseButtonFlags moonbit_sdl_event_motion_state(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.state;
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_event_motion_x(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.x;
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_event_motion_y(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.y;
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_event_motion_xrel(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.xrel;
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_event_motion_yrel(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.yrel;
}

MOONBIT_FFI_EXPORT
SDL_WindowID moonbit_sdl_event_button_window_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.windowID;
}

MOONBIT_FFI_EXPORT
SDL_MouseID moonbit_sdl_event_button_mouse_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.which;
}

MOONBIT_FFI_EXPORT
Uint8 moonbit_sdl_event_button_button(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.button;
}

MOONBIT_FFI_EXPORT
Uint8 moonbit_sdl_event_button_clicks(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.clicks;
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_event_button_x(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.x;
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_event_button_y(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.y;
}

MOONBIT_FFI_EXPORT
SDL_WindowID moonbit_sdl_event_window_window_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->window.windowID;
}

MOONBIT_FFI_EXPORT
Sint32 moonbit_sdl_event_window_data1(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->window.data1;
}

MOONBIT_FFI_EXPORT
Sint32 moonbit_sdl_event_window_data2(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->window.data2;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_event_text_text(moonbit_bytes_t self) {
  return moonbit_cstring_to_bytes_sdl(((SDL_Event *)self)->text.text);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_poll_event_ffi(moonbit_bytes_t event) {
  return SDL_PollEvent(((SDL_Event *)event));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_wait_event_timeout_ffi(moonbit_bytes_t event, Sint32 timeoutMS) {
  return SDL_WaitEventTimeout(((SDL_Event *)event), timeoutMS);
}
