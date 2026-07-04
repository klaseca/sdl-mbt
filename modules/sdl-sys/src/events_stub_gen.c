// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL.h"
#include <moonbit.h>
#include <stdint.h>
#include <string.h>

moonbit_bytes_t moonbit_cstring_to_bytes(const char *str);

moonbit_bytes_t moonbit_sdl_event_make() {
  SDL_Event value = { 0 };
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_Event), 0);
  memcpy(bytes, &value, sizeof(SDL_Event));
  return bytes;
}

Uint32 moonbit_sdl_event_event_type(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->type;
}

SDL_WindowID moonbit_sdl_event_key_window_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.windowID;
}

SDL_KeyboardID moonbit_sdl_event_key_keyboard_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.which;
}

SDL_Scancode moonbit_sdl_event_key_scancode(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.scancode;
}

SDL_Keycode moonbit_sdl_event_key_keycode(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.key;
}

SDL_Keymod moonbit_sdl_event_key_modifiers(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.mod;
}

int32_t moonbit_sdl_event_key_repeat(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->key.repeat;
}

SDL_WindowID moonbit_sdl_event_motion_window_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.windowID;
}

SDL_MouseID moonbit_sdl_event_motion_mouse_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.which;
}

SDL_MouseButtonFlags moonbit_sdl_event_motion_state(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.state;
}

float moonbit_sdl_event_motion_x(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.x;
}

float moonbit_sdl_event_motion_y(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.y;
}

float moonbit_sdl_event_motion_xrel(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.xrel;
}

float moonbit_sdl_event_motion_yrel(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->motion.yrel;
}

SDL_WindowID moonbit_sdl_event_button_window_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.windowID;
}

SDL_MouseID moonbit_sdl_event_button_mouse_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.which;
}

Uint8 moonbit_sdl_event_button_button(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.button;
}

Uint8 moonbit_sdl_event_button_clicks(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.clicks;
}

float moonbit_sdl_event_button_x(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.x;
}

float moonbit_sdl_event_button_y(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->button.y;
}

SDL_WindowID moonbit_sdl_event_window_window_id(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->window.windowID;
}

Sint32 moonbit_sdl_event_window_data1(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->window.data1;
}

Sint32 moonbit_sdl_event_window_data2(moonbit_bytes_t self) {
  return ((SDL_Event *)self)->window.data2;
}

moonbit_bytes_t moonbit_sdl_event_text_text(moonbit_bytes_t self) {
  return moonbit_cstring_to_bytes(((SDL_Event *)self)->text.text);
}

int32_t moonbit_sdl_poll_event_ffi(moonbit_bytes_t event) {
  return SDL_PollEvent((SDL_Event *)event);
}

int32_t moonbit_sdl_wait_event_timeout_ffi(moonbit_bytes_t event, Sint32 timeoutMS) {
  return SDL_WaitEventTimeout((SDL_Event *)event, timeoutMS);
}
