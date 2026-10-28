// Generated file. Do not edit by hand.

#include <SDL3/SDL_events.h>
#include <moonbit.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_windowevent_make(SDL_EventType arg_type_, uint32_t arg_reserved, uint64_t arg_timestamp, uint32_t arg_window_id, int32_t arg_data1, int32_t arg_data2) {
  SDL_WindowEvent value = { 0 };
  value.type = arg_type_;
  value.reserved = arg_reserved;
  value.timestamp = arg_timestamp;
  value.windowID = arg_window_id;
  value.data1 = arg_data1;
  value.data2 = arg_data2;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_WindowEvent), 0);
  memcpy(bytes, &value, sizeof(SDL_WindowEvent));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t *moonbit_sdl_windowevent_layout(void) {
  static const int32_t layout[] = {
    (int32_t)sizeof(SDL_WindowEvent),
    (int32_t)offsetof(SDL_WindowEvent, type),
    (int32_t)sizeof(((SDL_WindowEvent *)0)->type),
    ((SDL_EventType)-1 < (SDL_EventType)0),
    (int32_t)offsetof(SDL_WindowEvent, reserved),
    (int32_t)sizeof(((SDL_WindowEvent *)0)->reserved),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_WindowEvent, timestamp),
    (int32_t)sizeof(((SDL_WindowEvent *)0)->timestamp),
    ((uint64_t)-1 < (uint64_t)0),
    (int32_t)offsetof(SDL_WindowEvent, windowID),
    (int32_t)sizeof(((SDL_WindowEvent *)0)->windowID),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_WindowEvent, data1),
    (int32_t)sizeof(((SDL_WindowEvent *)0)->data1),
    ((int32_t)-1 < (int32_t)0),
    (int32_t)offsetof(SDL_WindowEvent, data2),
    (int32_t)sizeof(((SDL_WindowEvent *)0)->data2),
    ((int32_t)-1 < (int32_t)0),
  };
  int32_t *result = moonbit_make_int32_array(19, 0);
  memcpy(result, layout, sizeof(layout));
  return result;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_keyboardevent_make(SDL_EventType arg_type_, uint32_t arg_reserved, uint64_t arg_timestamp, uint32_t arg_window_id, uint32_t arg_which, SDL_Scancode arg_scancode, uint32_t arg_key, uint32_t arg_mod, uint32_t arg_raw, int32_t arg_down, int32_t arg_repeat) {
  SDL_KeyboardEvent value = { 0 };
  value.type = arg_type_;
  value.reserved = arg_reserved;
  value.timestamp = arg_timestamp;
  value.windowID = arg_window_id;
  value.which = arg_which;
  value.scancode = arg_scancode;
  value.key = arg_key;
  value.mod = arg_mod;
  value.raw = arg_raw;
  value.down = arg_down;
  value.repeat = arg_repeat;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_KeyboardEvent), 0);
  memcpy(bytes, &value, sizeof(SDL_KeyboardEvent));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t *moonbit_sdl_keyboardevent_layout(void) {
  static const int32_t layout[] = {
    (int32_t)sizeof(SDL_KeyboardEvent),
    (int32_t)offsetof(SDL_KeyboardEvent, type),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->type),
    ((SDL_EventType)-1 < (SDL_EventType)0),
    (int32_t)offsetof(SDL_KeyboardEvent, reserved),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->reserved),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_KeyboardEvent, timestamp),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->timestamp),
    ((uint64_t)-1 < (uint64_t)0),
    (int32_t)offsetof(SDL_KeyboardEvent, windowID),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->windowID),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_KeyboardEvent, which),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->which),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_KeyboardEvent, scancode),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->scancode),
    ((SDL_Scancode)-1 < (SDL_Scancode)0),
    (int32_t)offsetof(SDL_KeyboardEvent, key),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->key),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_KeyboardEvent, mod),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->mod),
    ((uint16_t)-1 < (uint16_t)0),
    (int32_t)offsetof(SDL_KeyboardEvent, raw),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->raw),
    ((uint16_t)-1 < (uint16_t)0),
    (int32_t)offsetof(SDL_KeyboardEvent, down),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->down),
    0,
    (int32_t)offsetof(SDL_KeyboardEvent, repeat),
    (int32_t)sizeof(((SDL_KeyboardEvent *)0)->repeat),
    0,
  };
  int32_t *result = moonbit_make_int32_array(34, 0);
  memcpy(result, layout, sizeof(layout));
  return result;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_textinputevent_make(void) {
  SDL_TextInputEvent value = { 0 };
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_TextInputEvent), 0);
  memcpy(bytes, &value, sizeof(SDL_TextInputEvent));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t *moonbit_sdl_textinputevent_layout(void) {
  static const int32_t layout[] = {
    (int32_t)sizeof(SDL_TextInputEvent),
    (int32_t)offsetof(SDL_TextInputEvent, type),
    (int32_t)sizeof(((SDL_TextInputEvent *)0)->type),
    ((SDL_EventType)-1 < (SDL_EventType)0),
    (int32_t)offsetof(SDL_TextInputEvent, reserved),
    (int32_t)sizeof(((SDL_TextInputEvent *)0)->reserved),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_TextInputEvent, timestamp),
    (int32_t)sizeof(((SDL_TextInputEvent *)0)->timestamp),
    ((uint64_t)-1 < (uint64_t)0),
    (int32_t)offsetof(SDL_TextInputEvent, windowID),
    (int32_t)sizeof(((SDL_TextInputEvent *)0)->windowID),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_TextInputEvent, text),
    (int32_t)sizeof(((SDL_TextInputEvent *)0)->text),
    0,
  };
  int32_t *result = moonbit_make_int32_array(16, 0);
  memcpy(result, layout, sizeof(layout));
  return result;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_mousemotionevent_make(SDL_EventType arg_type_, uint32_t arg_reserved, uint64_t arg_timestamp, uint32_t arg_window_id, uint32_t arg_which, uint32_t arg_state, float arg_x, float arg_y, float arg_xrel, float arg_yrel) {
  SDL_MouseMotionEvent value = { 0 };
  value.type = arg_type_;
  value.reserved = arg_reserved;
  value.timestamp = arg_timestamp;
  value.windowID = arg_window_id;
  value.which = arg_which;
  value.state = arg_state;
  value.x = arg_x;
  value.y = arg_y;
  value.xrel = arg_xrel;
  value.yrel = arg_yrel;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_MouseMotionEvent), 0);
  memcpy(bytes, &value, sizeof(SDL_MouseMotionEvent));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t *moonbit_sdl_mousemotionevent_layout(void) {
  static const int32_t layout[] = {
    (int32_t)sizeof(SDL_MouseMotionEvent),
    (int32_t)offsetof(SDL_MouseMotionEvent, type),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->type),
    ((SDL_EventType)-1 < (SDL_EventType)0),
    (int32_t)offsetof(SDL_MouseMotionEvent, reserved),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->reserved),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseMotionEvent, timestamp),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->timestamp),
    ((uint64_t)-1 < (uint64_t)0),
    (int32_t)offsetof(SDL_MouseMotionEvent, windowID),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->windowID),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseMotionEvent, which),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->which),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseMotionEvent, state),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->state),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseMotionEvent, x),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->x),
    0,
    (int32_t)offsetof(SDL_MouseMotionEvent, y),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->y),
    0,
    (int32_t)offsetof(SDL_MouseMotionEvent, xrel),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->xrel),
    0,
    (int32_t)offsetof(SDL_MouseMotionEvent, yrel),
    (int32_t)sizeof(((SDL_MouseMotionEvent *)0)->yrel),
    0,
  };
  int32_t *result = moonbit_make_int32_array(31, 0);
  memcpy(result, layout, sizeof(layout));
  return result;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_mousebuttonevent_make(SDL_EventType arg_type_, uint32_t arg_reserved, uint64_t arg_timestamp, uint32_t arg_window_id, uint32_t arg_which, uint8_t arg_button, int32_t arg_down, uint8_t arg_clicks, uint8_t arg_padding, float arg_x, float arg_y) {
  SDL_MouseButtonEvent value = { 0 };
  value.type = arg_type_;
  value.reserved = arg_reserved;
  value.timestamp = arg_timestamp;
  value.windowID = arg_window_id;
  value.which = arg_which;
  value.button = arg_button;
  value.down = arg_down;
  value.clicks = arg_clicks;
  value.padding = arg_padding;
  value.x = arg_x;
  value.y = arg_y;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_MouseButtonEvent), 0);
  memcpy(bytes, &value, sizeof(SDL_MouseButtonEvent));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t *moonbit_sdl_mousebuttonevent_layout(void) {
  static const int32_t layout[] = {
    (int32_t)sizeof(SDL_MouseButtonEvent),
    (int32_t)offsetof(SDL_MouseButtonEvent, type),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->type),
    ((SDL_EventType)-1 < (SDL_EventType)0),
    (int32_t)offsetof(SDL_MouseButtonEvent, reserved),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->reserved),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseButtonEvent, timestamp),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->timestamp),
    ((uint64_t)-1 < (uint64_t)0),
    (int32_t)offsetof(SDL_MouseButtonEvent, windowID),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->windowID),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseButtonEvent, which),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->which),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseButtonEvent, button),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->button),
    ((uint8_t)-1 < (uint8_t)0),
    (int32_t)offsetof(SDL_MouseButtonEvent, down),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->down),
    0,
    (int32_t)offsetof(SDL_MouseButtonEvent, clicks),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->clicks),
    ((uint8_t)-1 < (uint8_t)0),
    (int32_t)offsetof(SDL_MouseButtonEvent, padding),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->padding),
    ((uint8_t)-1 < (uint8_t)0),
    (int32_t)offsetof(SDL_MouseButtonEvent, x),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->x),
    0,
    (int32_t)offsetof(SDL_MouseButtonEvent, y),
    (int32_t)sizeof(((SDL_MouseButtonEvent *)0)->y),
    0,
  };
  int32_t *result = moonbit_make_int32_array(34, 0);
  memcpy(result, layout, sizeof(layout));
  return result;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_mousewheelevent_make(SDL_EventType arg_type_, uint32_t arg_reserved, uint64_t arg_timestamp, uint32_t arg_window_id, uint32_t arg_which, float arg_x, float arg_y, SDL_MouseWheelDirection arg_direction, float arg_mouse_x, float arg_mouse_y, int32_t arg_integer_x, int32_t arg_integer_y) {
  SDL_MouseWheelEvent value = { 0 };
  value.type = arg_type_;
  value.reserved = arg_reserved;
  value.timestamp = arg_timestamp;
  value.windowID = arg_window_id;
  value.which = arg_which;
  value.x = arg_x;
  value.y = arg_y;
  value.direction = arg_direction;
  value.mouse_x = arg_mouse_x;
  value.mouse_y = arg_mouse_y;
  value.integer_x = arg_integer_x;
  value.integer_y = arg_integer_y;
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_MouseWheelEvent), 0);
  memcpy(bytes, &value, sizeof(SDL_MouseWheelEvent));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t *moonbit_sdl_mousewheelevent_layout(void) {
  static const int32_t layout[] = {
    (int32_t)sizeof(SDL_MouseWheelEvent),
    (int32_t)offsetof(SDL_MouseWheelEvent, type),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->type),
    ((SDL_EventType)-1 < (SDL_EventType)0),
    (int32_t)offsetof(SDL_MouseWheelEvent, reserved),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->reserved),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseWheelEvent, timestamp),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->timestamp),
    ((uint64_t)-1 < (uint64_t)0),
    (int32_t)offsetof(SDL_MouseWheelEvent, windowID),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->windowID),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseWheelEvent, which),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->which),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_MouseWheelEvent, x),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->x),
    0,
    (int32_t)offsetof(SDL_MouseWheelEvent, y),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->y),
    0,
    (int32_t)offsetof(SDL_MouseWheelEvent, direction),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->direction),
    ((SDL_MouseWheelDirection)-1 < (SDL_MouseWheelDirection)0),
    (int32_t)offsetof(SDL_MouseWheelEvent, mouse_x),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->mouse_x),
    0,
    (int32_t)offsetof(SDL_MouseWheelEvent, mouse_y),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->mouse_y),
    0,
    (int32_t)offsetof(SDL_MouseWheelEvent, integer_x),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->integer_x),
    ((int32_t)-1 < (int32_t)0),
    (int32_t)offsetof(SDL_MouseWheelEvent, integer_y),
    (int32_t)sizeof(((SDL_MouseWheelEvent *)0)->integer_y),
    ((int32_t)-1 < (int32_t)0),
  };
  int32_t *result = moonbit_make_int32_array(37, 0);
  memcpy(result, layout, sizeof(layout));
  return result;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_event_make(void) {
  SDL_Event value = { 0 };
  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(SDL_Event), 0);
  memcpy(bytes, &value, sizeof(SDL_Event));
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t *moonbit_sdl_event_layout(void) {
  static const int32_t layout[] = {
    (int32_t)sizeof(SDL_Event),
    (int32_t)offsetof(SDL_Event, type),
    (int32_t)sizeof(((SDL_Event *)0)->type),
    ((uint32_t)-1 < (uint32_t)0),
    (int32_t)offsetof(SDL_Event, window),
    (int32_t)sizeof(((SDL_Event *)0)->window),
    0,
    (int32_t)offsetof(SDL_Event, key),
    (int32_t)sizeof(((SDL_Event *)0)->key),
    0,
    (int32_t)offsetof(SDL_Event, text),
    (int32_t)sizeof(((SDL_Event *)0)->text),
    0,
    (int32_t)offsetof(SDL_Event, motion),
    (int32_t)sizeof(((SDL_Event *)0)->motion),
    0,
    (int32_t)offsetof(SDL_Event, button),
    (int32_t)sizeof(((SDL_Event *)0)->button),
    0,
    (int32_t)offsetof(SDL_Event, wheel),
    (int32_t)sizeof(((SDL_Event *)0)->wheel),
    0,
  };
  int32_t *result = moonbit_make_int32_array(22, 0);
  memcpy(result, layout, sizeof(layout));
  return result;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_poll_event_ffi(moonbit_bytes_t event, int32_t event_offset) {
  return SDL_PollEvent(((SDL_Event *)(event + event_offset)));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_wait_event_timeout_ffi(moonbit_bytes_t event, int32_t event_offset, int32_t timeoutMS) {
  return SDL_WaitEventTimeout(((SDL_Event *)(event + event_offset)), timeoutMS);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_push_event_ffi(moonbit_bytes_t event, int32_t event_offset) {
  return SDL_PushEvent(((SDL_Event *)(event + event_offset)));
}

MOONBIT_FFI_EXPORT
uint32_t moonbit_sdl_register_events(int32_t numevents) {
  return SDL_RegisterEvents(numevents);
}
