// Generated file. Do not edit by hand.

///|
struct Event {
  bytes : Bytes
}

///|
extern "c" fn event_make() -> Bytes = "moonbit_sdl_event_make"

///|
pub fn Event::Event() -> Event {
  { bytes: event_make() }
}

///|
pub fn Event::to_bytes(self : Self) -> Bytes {
  self.bytes
}

///|
#borrow(bytes)
extern "c" fn event_event_type(bytes : Bytes) -> UInt = "moonbit_sdl_event_event_type"

///|
pub fn Event::event_type(self : Self) -> UInt {
  event_event_type(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_key_window_id(bytes : Bytes) -> UInt = "moonbit_sdl_event_key_window_id"

///|
pub fn Event::key_window_id(self : Self) -> UInt {
  event_key_window_id(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_key_keyboard_id(bytes : Bytes) -> UInt = "moonbit_sdl_event_key_keyboard_id"

///|
pub fn Event::key_keyboard_id(self : Self) -> UInt {
  event_key_keyboard_id(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_key_scancode(bytes : Bytes) -> Int = "moonbit_sdl_event_key_scancode"

///|
pub fn Event::key_scancode(self : Self) -> Int {
  event_key_scancode(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_key_keycode(bytes : Bytes) -> UInt = "moonbit_sdl_event_key_keycode"

///|
pub fn Event::key_keycode(self : Self) -> UInt {
  event_key_keycode(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_key_modifiers(bytes : Bytes) -> UInt16 = "moonbit_sdl_event_key_modifiers"

///|
pub fn Event::key_modifiers(self : Self) -> UInt16 {
  event_key_modifiers(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_key_repeat(bytes : Bytes) -> Bool = "moonbit_sdl_event_key_repeat"

///|
pub fn Event::key_repeat(self : Self) -> Bool {
  event_key_repeat(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_motion_window_id(bytes : Bytes) -> UInt = "moonbit_sdl_event_motion_window_id"

///|
pub fn Event::motion_window_id(self : Self) -> UInt {
  event_motion_window_id(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_motion_mouse_id(bytes : Bytes) -> UInt = "moonbit_sdl_event_motion_mouse_id"

///|
pub fn Event::motion_mouse_id(self : Self) -> UInt {
  event_motion_mouse_id(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_motion_state(bytes : Bytes) -> UInt = "moonbit_sdl_event_motion_state"

///|
pub fn Event::motion_state(self : Self) -> UInt {
  event_motion_state(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_motion_x(bytes : Bytes) -> Float = "moonbit_sdl_event_motion_x"

///|
pub fn Event::motion_x(self : Self) -> Float {
  event_motion_x(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_motion_y(bytes : Bytes) -> Float = "moonbit_sdl_event_motion_y"

///|
pub fn Event::motion_y(self : Self) -> Float {
  event_motion_y(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_motion_xrel(bytes : Bytes) -> Float = "moonbit_sdl_event_motion_xrel"

///|
pub fn Event::motion_xrel(self : Self) -> Float {
  event_motion_xrel(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_motion_yrel(bytes : Bytes) -> Float = "moonbit_sdl_event_motion_yrel"

///|
pub fn Event::motion_yrel(self : Self) -> Float {
  event_motion_yrel(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_button_window_id(bytes : Bytes) -> UInt = "moonbit_sdl_event_button_window_id"

///|
pub fn Event::button_window_id(self : Self) -> UInt {
  event_button_window_id(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_button_mouse_id(bytes : Bytes) -> UInt = "moonbit_sdl_event_button_mouse_id"

///|
pub fn Event::button_mouse_id(self : Self) -> UInt {
  event_button_mouse_id(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_button_button(bytes : Bytes) -> Byte = "moonbit_sdl_event_button_button"

///|
pub fn Event::button_button(self : Self) -> Byte {
  event_button_button(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_button_clicks(bytes : Bytes) -> Byte = "moonbit_sdl_event_button_clicks"

///|
pub fn Event::button_clicks(self : Self) -> Byte {
  event_button_clicks(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_button_x(bytes : Bytes) -> Float = "moonbit_sdl_event_button_x"

///|
pub fn Event::button_x(self : Self) -> Float {
  event_button_x(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_button_y(bytes : Bytes) -> Float = "moonbit_sdl_event_button_y"

///|
pub fn Event::button_y(self : Self) -> Float {
  event_button_y(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_window_window_id(bytes : Bytes) -> UInt = "moonbit_sdl_event_window_window_id"

///|
pub fn Event::window_window_id(self : Self) -> UInt {
  event_window_window_id(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_window_data1(bytes : Bytes) -> Int = "moonbit_sdl_event_window_data1"

///|
pub fn Event::window_data1(self : Self) -> Int {
  event_window_data1(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_window_data2(bytes : Bytes) -> Int = "moonbit_sdl_event_window_data2"

///|
pub fn Event::window_data2(self : Self) -> Int {
  event_window_data2(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn event_text_text(bytes : Bytes) -> Bytes = "moonbit_sdl_event_text_text"

///|
pub fn Event::text_text(self : Self) -> Bytes {
  event_text_text(self.to_bytes())
}

///|
pub const EVENT_FIRST : UInt = 0

///|
pub const EVENT_QUIT : UInt = 0x100

///|
pub const EVENT_TERMINATING : UInt = 257

///|
pub const EVENT_LOW_MEMORY : UInt = 258

///|
pub const EVENT_WILL_ENTER_BACKGROUND : UInt = 259

///|
pub const EVENT_DID_ENTER_BACKGROUND : UInt = 260

///|
pub const EVENT_WILL_ENTER_FOREGROUND : UInt = 261

///|
pub const EVENT_DID_ENTER_FOREGROUND : UInt = 262

///|
pub const EVENT_LOCALE_CHANGED : UInt = 263

///|
pub const EVENT_SYSTEM_THEME_CHANGED : UInt = 264

///|
pub const EVENT_DISPLAY_ORIENTATION : UInt = 0x151

///|
pub const EVENT_DISPLAY_ADDED : UInt = 338

///|
pub const EVENT_DISPLAY_REMOVED : UInt = 339

///|
pub const EVENT_DISPLAY_MOVED : UInt = 340

///|
pub const EVENT_DISPLAY_DESKTOP_MODE_CHANGED : UInt = 341

///|
pub const EVENT_DISPLAY_CURRENT_MODE_CHANGED : UInt = 342

///|
pub const EVENT_DISPLAY_CONTENT_SCALE_CHANGED : UInt = 343

///|
pub const EVENT_DISPLAY_USABLE_BOUNDS_CHANGED : UInt = 344

///|
pub const EVENT_WINDOW_SHOWN : UInt = 0x202

///|
pub const EVENT_WINDOW_HIDDEN : UInt = 515

///|
pub const EVENT_WINDOW_EXPOSED : UInt = 516

///|
pub const EVENT_WINDOW_MOVED : UInt = 517

///|
pub const EVENT_WINDOW_RESIZED : UInt = 518

///|
pub const EVENT_WINDOW_PIXEL_SIZE_CHANGED : UInt = 519

///|
pub const EVENT_WINDOW_METAL_VIEW_RESIZED : UInt = 520

///|
pub const EVENT_WINDOW_MINIMIZED : UInt = 521

///|
pub const EVENT_WINDOW_MAXIMIZED : UInt = 522

///|
pub const EVENT_WINDOW_RESTORED : UInt = 523

///|
pub const EVENT_WINDOW_MOUSE_ENTER : UInt = 524

///|
pub const EVENT_WINDOW_MOUSE_LEAVE : UInt = 525

///|
pub const EVENT_WINDOW_FOCUS_GAINED : UInt = 526

///|
pub const EVENT_WINDOW_FOCUS_LOST : UInt = 527

///|
pub const EVENT_WINDOW_CLOSE_REQUESTED : UInt = 528

///|
pub const EVENT_WINDOW_HIT_TEST : UInt = 529

///|
pub const EVENT_WINDOW_ICCPROF_CHANGED : UInt = 530

///|
pub const EVENT_WINDOW_DISPLAY_CHANGED : UInt = 531

///|
pub const EVENT_WINDOW_DISPLAY_SCALE_CHANGED : UInt = 532

///|
pub const EVENT_WINDOW_SAFE_AREA_CHANGED : UInt = 533

///|
pub const EVENT_WINDOW_OCCLUDED : UInt = 534

///|
pub const EVENT_WINDOW_ENTER_FULLSCREEN : UInt = 535

///|
pub const EVENT_WINDOW_LEAVE_FULLSCREEN : UInt = 536

///|
pub const EVENT_WINDOW_DESTROYED : UInt = 537

///|
pub const EVENT_WINDOW_HDR_STATE_CHANGED : UInt = 538

///|
pub const EVENT_WINDOW_SETTINGS_CHANGED : UInt = 539

///|
pub const EVENT_KEY_DOWN : UInt = 0x300

///|
pub const EVENT_KEY_UP : UInt = 769

///|
pub const EVENT_TEXT_EDITING : UInt = 770

///|
pub const EVENT_TEXT_INPUT : UInt = 771

///|
pub const EVENT_KEYMAP_CHANGED : UInt = 772

///|
pub const EVENT_KEYBOARD_ADDED : UInt = 773

///|
pub const EVENT_KEYBOARD_REMOVED : UInt = 774

///|
pub const EVENT_TEXT_EDITING_CANDIDATES : UInt = 775

///|
pub const EVENT_SCREEN_KEYBOARD_SHOWN : UInt = 776

///|
pub const EVENT_SCREEN_KEYBOARD_HIDDEN : UInt = 777

///|
pub const EVENT_MOUSE_MOTION : UInt = 0x400

///|
pub const EVENT_MOUSE_BUTTON_DOWN : UInt = 1025

///|
pub const EVENT_MOUSE_BUTTON_UP : UInt = 1026

///|
pub const EVENT_MOUSE_WHEEL : UInt = 1027

///|
pub const EVENT_MOUSE_ADDED : UInt = 1028

///|
pub const EVENT_MOUSE_REMOVED : UInt = 1029

///|
pub const EVENT_JOYSTICK_AXIS_MOTION : UInt = 0x600

///|
pub const EVENT_JOYSTICK_BALL_MOTION : UInt = 1537

///|
pub const EVENT_JOYSTICK_HAT_MOTION : UInt = 1538

///|
pub const EVENT_JOYSTICK_BUTTON_DOWN : UInt = 1539

///|
pub const EVENT_JOYSTICK_BUTTON_UP : UInt = 1540

///|
pub const EVENT_JOYSTICK_ADDED : UInt = 1541

///|
pub const EVENT_JOYSTICK_REMOVED : UInt = 1542

///|
pub const EVENT_JOYSTICK_BATTERY_UPDATED : UInt = 1543

///|
pub const EVENT_JOYSTICK_UPDATE_COMPLETE : UInt = 1544

///|
pub const EVENT_GAMEPAD_AXIS_MOTION : UInt = 0x650

///|
pub const EVENT_GAMEPAD_BUTTON_DOWN : UInt = 1617

///|
pub const EVENT_GAMEPAD_BUTTON_UP : UInt = 1618

///|
pub const EVENT_GAMEPAD_ADDED : UInt = 1619

///|
pub const EVENT_GAMEPAD_REMOVED : UInt = 1620

///|
pub const EVENT_GAMEPAD_REMAPPED : UInt = 1621

///|
pub const EVENT_GAMEPAD_TOUCHPAD_DOWN : UInt = 1622

///|
pub const EVENT_GAMEPAD_TOUCHPAD_MOTION : UInt = 1623

///|
pub const EVENT_GAMEPAD_TOUCHPAD_UP : UInt = 1624

///|
pub const EVENT_GAMEPAD_SENSOR_UPDATE : UInt = 1625

///|
pub const EVENT_GAMEPAD_UPDATE_COMPLETE : UInt = 1626

///|
pub const EVENT_GAMEPAD_STEAM_HANDLE_UPDATED : UInt = 1627

///|
pub const EVENT_GAMEPAD_CAPSENSE_TOUCH : UInt = 1628

///|
pub const EVENT_GAMEPAD_CAPSENSE_RELEASE : UInt = 1629

///|
pub const EVENT_FINGER_DOWN : UInt = 0x700

///|
pub const EVENT_FINGER_UP : UInt = 1793

///|
pub const EVENT_FINGER_MOTION : UInt = 1794

///|
pub const EVENT_FINGER_CANCELED : UInt = 1795

///|
pub const EVENT_PINCH_BEGIN : UInt = 0x710

///|
pub const EVENT_PINCH_UPDATE : UInt = 1809

///|
pub const EVENT_PINCH_END : UInt = 1810

///|
pub const EVENT_CLIPBOARD_UPDATE : UInt = 0x900

///|
pub const EVENT_DROP_FILE : UInt = 0x1000

///|
pub const EVENT_DROP_TEXT : UInt = 4097

///|
pub const EVENT_DROP_BEGIN : UInt = 4098

///|
pub const EVENT_DROP_COMPLETE : UInt = 4099

///|
pub const EVENT_DROP_POSITION : UInt = 4100

///|
pub const EVENT_AUDIO_DEVICE_ADDED : UInt = 0x1100

///|
pub const EVENT_AUDIO_DEVICE_REMOVED : UInt = 4353

///|
pub const EVENT_AUDIO_DEVICE_FORMAT_CHANGED : UInt = 4354

///|
pub const EVENT_SENSOR_UPDATE : UInt = 0x1200

///|
pub const EVENT_PEN_PROXIMITY_IN : UInt = 0x1300

///|
pub const EVENT_PEN_PROXIMITY_OUT : UInt = 4865

///|
pub const EVENT_PEN_DOWN : UInt = 4866

///|
pub const EVENT_PEN_UP : UInt = 4867

///|
pub const EVENT_PEN_BUTTON_DOWN : UInt = 4868

///|
pub const EVENT_PEN_BUTTON_UP : UInt = 4869

///|
pub const EVENT_PEN_MOTION : UInt = 4870

///|
pub const EVENT_PEN_AXIS : UInt = 4871

///|
pub const EVENT_CAMERA_DEVICE_ADDED : UInt = 0x1400

///|
pub const EVENT_CAMERA_DEVICE_REMOVED : UInt = 5121

///|
pub const EVENT_CAMERA_DEVICE_APPROVED : UInt = 5122

///|
pub const EVENT_CAMERA_DEVICE_DENIED : UInt = 5123

///|
pub const EVENT_RENDER_TARGETS_RESET : UInt = 0x2000

///|
pub const EVENT_RENDER_DEVICE_RESET : UInt = 8193

///|
pub const EVENT_RENDER_DEVICE_LOST : UInt = 8194

///|
pub const EVENT_PRIVATE0 : UInt = 0x4000

///|
pub const EVENT_PRIVATE1 : UInt = 16385

///|
pub const EVENT_PRIVATE2 : UInt = 16386

///|
pub const EVENT_PRIVATE3 : UInt = 16387

///|
pub const EVENT_POLL_SENTINEL : UInt = 0x7F00

///|
pub const EVENT_USER : UInt = 0x8000

///|
pub const EVENT_LAST : UInt = 0xFFFF

///|
pub const EVENT_ENUM_PADDING : UInt = 0x7FFFFFFF

///|
#borrow(event)
extern "c" fn poll_event_ffi(event : Bytes) -> Bool = "moonbit_sdl_poll_event_ffi"

///|
pub fn poll_event(event : Event) -> Bool {
  poll_event_ffi(event.to_bytes())
}

///|
#borrow(event)
extern "c" fn wait_event_timeout_ffi(event : Bytes, timeoutMS : Int) -> Bool = "moonbit_sdl_wait_event_timeout_ffi"

///|
pub fn wait_event_timeout(event : Event, timeoutMS : Int) -> Bool {
  wait_event_timeout_ffi(event.to_bytes(), timeoutMS)
}
