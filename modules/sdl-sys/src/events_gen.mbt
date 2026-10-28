// Generated file. Do not edit by hand.

///|
struct WindowEvent {
  bytes : Bytes
  offset : Int32
}

///|
extern "c" fn windowevent_make(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, data1 : Int32, data2 : Int32) -> Bytes = "moonbit_sdl_windowevent_make"

///|
pub fn WindowEvent::WindowEvent(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, data1 : Int32, data2 : Int32) -> WindowEvent {
  { bytes: windowevent_make(type_, reserved, timestamp, window_id, data1, data2), offset: 0 }
}

///|
extern "c" fn windowevent_layout_ffi() -> FixedArray[Int32] = "moonbit_sdl_windowevent_layout"

///|
let windowevent_layout : FixedArray[Int32] = windowevent_layout_ffi()

///|
/// View exactly the structure bytes without copying; writes and native buffer reuse are shared.
pub fn WindowEvent::as_bytes(self : Self) -> BytesView {
  self.bytes.exact_view(start=self.offset, end=self.offset + windowevent_layout[0])
}

///|
/// Copy the structure bytes into independent storage. Native pointers remain shallow copies.
pub fn WindowEvent::copy(self : Self) -> Self {
  { bytes: value_copy_bytes(self.bytes, self.offset, windowevent_layout[0]), offset: 0 }
}

///|
pub fn WindowEvent::type_(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + windowevent_layout[1], windowevent_layout[2], windowevent_layout[3] != 0, value_little_endian)
}

///|
pub fn WindowEvent::reserved(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + windowevent_layout[4], windowevent_layout[5], windowevent_layout[6] != 0, value_little_endian)
}

///|
pub fn WindowEvent::timestamp(self : Self) -> UInt64 {
  read_integer(self.bytes, self.offset + windowevent_layout[7], windowevent_layout[8], windowevent_layout[9] != 0, value_little_endian)
}

///|
pub fn WindowEvent::window_id(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + windowevent_layout[10], windowevent_layout[11], windowevent_layout[12] != 0, value_little_endian)
}

///|
pub fn WindowEvent::data1(self : Self) -> Int32 {
  read_integer(self.bytes, self.offset + windowevent_layout[13], windowevent_layout[14], windowevent_layout[15] != 0, value_little_endian)
}

///|
pub fn WindowEvent::data2(self : Self) -> Int32 {
  read_integer(self.bytes, self.offset + windowevent_layout[16], windowevent_layout[17], windowevent_layout[18] != 0, value_little_endian)
}

///|
pub fn WindowEvent::set_type(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + windowevent_layout[1], windowevent_layout[2], value.to_uint64())
}

///|
pub fn WindowEvent::set_reserved(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + windowevent_layout[4], windowevent_layout[5], value.to_uint64())
}

///|
pub fn WindowEvent::set_timestamp(self : Self, value : UInt64) -> Unit {
  value_write_bits(self.bytes, self.offset + windowevent_layout[7], windowevent_layout[8], value)
}

///|
pub fn WindowEvent::set_window_id(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + windowevent_layout[10], windowevent_layout[11], value.to_uint64())
}

///|
pub fn WindowEvent::set_data1(self : Self, value : Int32) -> Unit {
  value_write_bits(self.bytes, self.offset + windowevent_layout[13], windowevent_layout[14], Int64::from_int(value).reinterpret_as_uint64())
}

///|
pub fn WindowEvent::set_data2(self : Self, value : Int32) -> Unit {
  value_write_bits(self.bytes, self.offset + windowevent_layout[16], windowevent_layout[17], Int64::from_int(value).reinterpret_as_uint64())
}

///|
struct KeyboardEvent {
  bytes : Bytes
  offset : Int32
}

///|
extern "c" fn keyboardevent_make(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, which : UInt32, scancode : Int32, key : UInt32, mod : UInt32, raw : UInt32, down : Bool, repeat : Bool) -> Bytes = "moonbit_sdl_keyboardevent_make"

///|
pub fn KeyboardEvent::KeyboardEvent(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, which : UInt32, scancode : Int32, key : UInt32, mod : UInt32, raw : UInt32, down : Bool, repeat : Bool) -> KeyboardEvent {
  { bytes: keyboardevent_make(type_, reserved, timestamp, window_id, which, scancode, key, mod, raw, down, repeat), offset: 0 }
}

///|
extern "c" fn keyboardevent_layout_ffi() -> FixedArray[Int32] = "moonbit_sdl_keyboardevent_layout"

///|
let keyboardevent_layout : FixedArray[Int32] = keyboardevent_layout_ffi()

///|
/// View exactly the structure bytes without copying; writes and native buffer reuse are shared.
pub fn KeyboardEvent::as_bytes(self : Self) -> BytesView {
  self.bytes.exact_view(start=self.offset, end=self.offset + keyboardevent_layout[0])
}

///|
/// Copy the structure bytes into independent storage. Native pointers remain shallow copies.
pub fn KeyboardEvent::copy(self : Self) -> Self {
  { bytes: value_copy_bytes(self.bytes, self.offset, keyboardevent_layout[0]), offset: 0 }
}

///|
pub fn KeyboardEvent::type_(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + keyboardevent_layout[1], keyboardevent_layout[2], keyboardevent_layout[3] != 0, value_little_endian)
}

///|
pub fn KeyboardEvent::reserved(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + keyboardevent_layout[4], keyboardevent_layout[5], keyboardevent_layout[6] != 0, value_little_endian)
}

///|
pub fn KeyboardEvent::timestamp(self : Self) -> UInt64 {
  read_integer(self.bytes, self.offset + keyboardevent_layout[7], keyboardevent_layout[8], keyboardevent_layout[9] != 0, value_little_endian)
}

///|
pub fn KeyboardEvent::window_id(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + keyboardevent_layout[10], keyboardevent_layout[11], keyboardevent_layout[12] != 0, value_little_endian)
}

///|
pub fn KeyboardEvent::which(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + keyboardevent_layout[13], keyboardevent_layout[14], keyboardevent_layout[15] != 0, value_little_endian)
}

///|
pub fn KeyboardEvent::scancode(self : Self) -> Int32 {
  read_integer(self.bytes, self.offset + keyboardevent_layout[16], keyboardevent_layout[17], keyboardevent_layout[18] != 0, value_little_endian)
}

///|
pub fn KeyboardEvent::key(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + keyboardevent_layout[19], keyboardevent_layout[20], keyboardevent_layout[21] != 0, value_little_endian)
}

///|
pub fn KeyboardEvent::mod(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + keyboardevent_layout[22], keyboardevent_layout[23], keyboardevent_layout[24] != 0, value_little_endian)
}

///|
pub fn KeyboardEvent::raw(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + keyboardevent_layout[25], keyboardevent_layout[26], keyboardevent_layout[27] != 0, value_little_endian)
}

///|
pub fn KeyboardEvent::down(self : Self) -> Bool {
  value_read_bool(self.bytes, self.offset + keyboardevent_layout[28], keyboardevent_layout[29])
}

///|
pub fn KeyboardEvent::repeat(self : Self) -> Bool {
  value_read_bool(self.bytes, self.offset + keyboardevent_layout[31], keyboardevent_layout[32])
}

///|
pub fn KeyboardEvent::set_type(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[1], keyboardevent_layout[2], value.to_uint64())
}

///|
pub fn KeyboardEvent::set_reserved(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[4], keyboardevent_layout[5], value.to_uint64())
}

///|
pub fn KeyboardEvent::set_timestamp(self : Self, value : UInt64) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[7], keyboardevent_layout[8], value)
}

///|
pub fn KeyboardEvent::set_window_id(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[10], keyboardevent_layout[11], value.to_uint64())
}

///|
pub fn KeyboardEvent::set_which(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[13], keyboardevent_layout[14], value.to_uint64())
}

///|
pub fn KeyboardEvent::set_scancode(self : Self, value : Int32) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[16], keyboardevent_layout[17], Int64::from_int(value).reinterpret_as_uint64())
}

///|
pub fn KeyboardEvent::set_key(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[19], keyboardevent_layout[20], value.to_uint64())
}

///|
pub fn KeyboardEvent::set_mod(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[22], keyboardevent_layout[23], value.to_uint64())
}

///|
pub fn KeyboardEvent::set_raw(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[25], keyboardevent_layout[26], value.to_uint64())
}

///|
pub fn KeyboardEvent::set_down(self : Self, value : Bool) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[28], keyboardevent_layout[29], if value { 1UL } else { 0UL })
}

///|
pub fn KeyboardEvent::set_repeat(self : Self, value : Bool) -> Unit {
  value_write_bits(self.bytes, self.offset + keyboardevent_layout[31], keyboardevent_layout[32], if value { 1UL } else { 0UL })
}

///|
struct TextInputEvent {
  bytes : Bytes
  offset : Int32
}

///|
extern "c" fn textinputevent_make() -> Bytes = "moonbit_sdl_textinputevent_make"

///|
pub fn TextInputEvent::TextInputEvent() -> TextInputEvent {
  { bytes: textinputevent_make(), offset: 0 }
}

///|
extern "c" fn textinputevent_layout_ffi() -> FixedArray[Int32] = "moonbit_sdl_textinputevent_layout"

///|
let textinputevent_layout : FixedArray[Int32] = textinputevent_layout_ffi()

///|
/// View exactly the structure bytes without copying; writes and native buffer reuse are shared.
pub fn TextInputEvent::as_bytes(self : Self) -> BytesView {
  self.bytes.exact_view(start=self.offset, end=self.offset + textinputevent_layout[0])
}

///|
/// Copy the structure bytes into independent storage. Native pointers remain shallow copies.
pub fn TextInputEvent::copy(self : Self) -> Self {
  { bytes: value_copy_bytes(self.bytes, self.offset, textinputevent_layout[0]), offset: 0 }
}

///|
pub fn TextInputEvent::type_(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + textinputevent_layout[1], textinputevent_layout[2], textinputevent_layout[3] != 0, value_little_endian)
}

///|
pub fn TextInputEvent::reserved(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + textinputevent_layout[4], textinputevent_layout[5], textinputevent_layout[6] != 0, value_little_endian)
}

///|
pub fn TextInputEvent::timestamp(self : Self) -> UInt64 {
  read_integer(self.bytes, self.offset + textinputevent_layout[7], textinputevent_layout[8], textinputevent_layout[9] != 0, value_little_endian)
}

///|
pub fn TextInputEvent::window_id(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + textinputevent_layout[10], textinputevent_layout[11], textinputevent_layout[12] != 0, value_little_endian)
}

///|
pub fn TextInputEvent::text(self : Self) -> Bytes {
  value_read_cstring(self.bytes, self.offset + textinputevent_layout[13])
}

///|
struct MouseMotionEvent {
  bytes : Bytes
  offset : Int32
}

///|
extern "c" fn mousemotionevent_make(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, which : UInt32, state : UInt32, x : Float, y : Float, xrel : Float, yrel : Float) -> Bytes = "moonbit_sdl_mousemotionevent_make"

///|
pub fn MouseMotionEvent::MouseMotionEvent(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, which : UInt32, state : UInt32, x : Float, y : Float, xrel : Float, yrel : Float) -> MouseMotionEvent {
  { bytes: mousemotionevent_make(type_, reserved, timestamp, window_id, which, state, x, y, xrel, yrel), offset: 0 }
}

///|
extern "c" fn mousemotionevent_layout_ffi() -> FixedArray[Int32] = "moonbit_sdl_mousemotionevent_layout"

///|
let mousemotionevent_layout : FixedArray[Int32] = mousemotionevent_layout_ffi()

///|
/// View exactly the structure bytes without copying; writes and native buffer reuse are shared.
pub fn MouseMotionEvent::as_bytes(self : Self) -> BytesView {
  self.bytes.exact_view(start=self.offset, end=self.offset + mousemotionevent_layout[0])
}

///|
/// Copy the structure bytes into independent storage. Native pointers remain shallow copies.
pub fn MouseMotionEvent::copy(self : Self) -> Self {
  { bytes: value_copy_bytes(self.bytes, self.offset, mousemotionevent_layout[0]), offset: 0 }
}

///|
pub fn MouseMotionEvent::type_(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousemotionevent_layout[1], mousemotionevent_layout[2], mousemotionevent_layout[3] != 0, value_little_endian)
}

///|
pub fn MouseMotionEvent::reserved(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousemotionevent_layout[4], mousemotionevent_layout[5], mousemotionevent_layout[6] != 0, value_little_endian)
}

///|
pub fn MouseMotionEvent::timestamp(self : Self) -> UInt64 {
  read_integer(self.bytes, self.offset + mousemotionevent_layout[7], mousemotionevent_layout[8], mousemotionevent_layout[9] != 0, value_little_endian)
}

///|
pub fn MouseMotionEvent::window_id(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousemotionevent_layout[10], mousemotionevent_layout[11], mousemotionevent_layout[12] != 0, value_little_endian)
}

///|
pub fn MouseMotionEvent::which(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousemotionevent_layout[13], mousemotionevent_layout[14], mousemotionevent_layout[15] != 0, value_little_endian)
}

///|
pub fn MouseMotionEvent::state(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousemotionevent_layout[16], mousemotionevent_layout[17], mousemotionevent_layout[18] != 0, value_little_endian)
}

///|
pub fn MouseMotionEvent::x(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousemotionevent_layout[19], mousemotionevent_layout[20], value_little_endian)
}

///|
pub fn MouseMotionEvent::y(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousemotionevent_layout[22], mousemotionevent_layout[23], value_little_endian)
}

///|
pub fn MouseMotionEvent::xrel(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousemotionevent_layout[25], mousemotionevent_layout[26], value_little_endian)
}

///|
pub fn MouseMotionEvent::yrel(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousemotionevent_layout[28], mousemotionevent_layout[29], value_little_endian)
}

///|
pub fn MouseMotionEvent::set_type(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[1], mousemotionevent_layout[2], value.to_uint64())
}

///|
pub fn MouseMotionEvent::set_reserved(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[4], mousemotionevent_layout[5], value.to_uint64())
}

///|
pub fn MouseMotionEvent::set_timestamp(self : Self, value : UInt64) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[7], mousemotionevent_layout[8], value)
}

///|
pub fn MouseMotionEvent::set_window_id(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[10], mousemotionevent_layout[11], value.to_uint64())
}

///|
pub fn MouseMotionEvent::set_which(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[13], mousemotionevent_layout[14], value.to_uint64())
}

///|
pub fn MouseMotionEvent::set_state(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[16], mousemotionevent_layout[17], value.to_uint64())
}

///|
pub fn MouseMotionEvent::set_x(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[19], mousemotionevent_layout[20], value.reinterpret_as_uint().to_uint64())
}

///|
pub fn MouseMotionEvent::set_y(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[22], mousemotionevent_layout[23], value.reinterpret_as_uint().to_uint64())
}

///|
pub fn MouseMotionEvent::set_xrel(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[25], mousemotionevent_layout[26], value.reinterpret_as_uint().to_uint64())
}

///|
pub fn MouseMotionEvent::set_yrel(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousemotionevent_layout[28], mousemotionevent_layout[29], value.reinterpret_as_uint().to_uint64())
}

///|
struct MouseButtonEvent {
  bytes : Bytes
  offset : Int32
}

///|
extern "c" fn mousebuttonevent_make(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, which : UInt32, button : Byte, down : Bool, clicks : Byte, padding : Byte, x : Float, y : Float) -> Bytes = "moonbit_sdl_mousebuttonevent_make"

///|
pub fn MouseButtonEvent::MouseButtonEvent(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, which : UInt32, button : Byte, down : Bool, clicks : Byte, padding : Byte, x : Float, y : Float) -> MouseButtonEvent {
  { bytes: mousebuttonevent_make(type_, reserved, timestamp, window_id, which, button, down, clicks, padding, x, y), offset: 0 }
}

///|
extern "c" fn mousebuttonevent_layout_ffi() -> FixedArray[Int32] = "moonbit_sdl_mousebuttonevent_layout"

///|
let mousebuttonevent_layout : FixedArray[Int32] = mousebuttonevent_layout_ffi()

///|
/// View exactly the structure bytes without copying; writes and native buffer reuse are shared.
pub fn MouseButtonEvent::as_bytes(self : Self) -> BytesView {
  self.bytes.exact_view(start=self.offset, end=self.offset + mousebuttonevent_layout[0])
}

///|
/// Copy the structure bytes into independent storage. Native pointers remain shallow copies.
pub fn MouseButtonEvent::copy(self : Self) -> Self {
  { bytes: value_copy_bytes(self.bytes, self.offset, mousebuttonevent_layout[0]), offset: 0 }
}

///|
pub fn MouseButtonEvent::type_(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousebuttonevent_layout[1], mousebuttonevent_layout[2], mousebuttonevent_layout[3] != 0, value_little_endian)
}

///|
pub fn MouseButtonEvent::reserved(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousebuttonevent_layout[4], mousebuttonevent_layout[5], mousebuttonevent_layout[6] != 0, value_little_endian)
}

///|
pub fn MouseButtonEvent::timestamp(self : Self) -> UInt64 {
  read_integer(self.bytes, self.offset + mousebuttonevent_layout[7], mousebuttonevent_layout[8], mousebuttonevent_layout[9] != 0, value_little_endian)
}

///|
pub fn MouseButtonEvent::window_id(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousebuttonevent_layout[10], mousebuttonevent_layout[11], mousebuttonevent_layout[12] != 0, value_little_endian)
}

///|
pub fn MouseButtonEvent::which(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousebuttonevent_layout[13], mousebuttonevent_layout[14], mousebuttonevent_layout[15] != 0, value_little_endian)
}

///|
pub fn MouseButtonEvent::button(self : Self) -> Byte {
  value_read_byte(self.bytes, self.offset + mousebuttonevent_layout[16], mousebuttonevent_layout[17], value_little_endian)
}

///|
pub fn MouseButtonEvent::down(self : Self) -> Bool {
  value_read_bool(self.bytes, self.offset + mousebuttonevent_layout[19], mousebuttonevent_layout[20])
}

///|
pub fn MouseButtonEvent::clicks(self : Self) -> Byte {
  value_read_byte(self.bytes, self.offset + mousebuttonevent_layout[22], mousebuttonevent_layout[23], value_little_endian)
}

///|
pub fn MouseButtonEvent::padding(self : Self) -> Byte {
  value_read_byte(self.bytes, self.offset + mousebuttonevent_layout[25], mousebuttonevent_layout[26], value_little_endian)
}

///|
pub fn MouseButtonEvent::x(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousebuttonevent_layout[28], mousebuttonevent_layout[29], value_little_endian)
}

///|
pub fn MouseButtonEvent::y(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousebuttonevent_layout[31], mousebuttonevent_layout[32], value_little_endian)
}

///|
pub fn MouseButtonEvent::set_type(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[1], mousebuttonevent_layout[2], value.to_uint64())
}

///|
pub fn MouseButtonEvent::set_reserved(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[4], mousebuttonevent_layout[5], value.to_uint64())
}

///|
pub fn MouseButtonEvent::set_timestamp(self : Self, value : UInt64) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[7], mousebuttonevent_layout[8], value)
}

///|
pub fn MouseButtonEvent::set_window_id(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[10], mousebuttonevent_layout[11], value.to_uint64())
}

///|
pub fn MouseButtonEvent::set_which(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[13], mousebuttonevent_layout[14], value.to_uint64())
}

///|
pub fn MouseButtonEvent::set_button(self : Self, value : Byte) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[16], mousebuttonevent_layout[17], value.to_uint().to_uint64())
}

///|
pub fn MouseButtonEvent::set_down(self : Self, value : Bool) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[19], mousebuttonevent_layout[20], if value { 1UL } else { 0UL })
}

///|
pub fn MouseButtonEvent::set_clicks(self : Self, value : Byte) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[22], mousebuttonevent_layout[23], value.to_uint().to_uint64())
}

///|
pub fn MouseButtonEvent::set_padding(self : Self, value : Byte) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[25], mousebuttonevent_layout[26], value.to_uint().to_uint64())
}

///|
pub fn MouseButtonEvent::set_x(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[28], mousebuttonevent_layout[29], value.reinterpret_as_uint().to_uint64())
}

///|
pub fn MouseButtonEvent::set_y(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousebuttonevent_layout[31], mousebuttonevent_layout[32], value.reinterpret_as_uint().to_uint64())
}

///|
struct MouseWheelEvent {
  bytes : Bytes
  offset : Int32
}

///|
extern "c" fn mousewheelevent_make(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, which : UInt32, x : Float, y : Float, direction : UInt32, mouse_x : Float, mouse_y : Float, integer_x : Int32, integer_y : Int32) -> Bytes = "moonbit_sdl_mousewheelevent_make"

///|
pub fn MouseWheelEvent::MouseWheelEvent(type_ : UInt32, reserved : UInt32, timestamp : UInt64, window_id : UInt32, which : UInt32, x : Float, y : Float, direction : UInt32, mouse_x : Float, mouse_y : Float, integer_x : Int32, integer_y : Int32) -> MouseWheelEvent {
  { bytes: mousewheelevent_make(type_, reserved, timestamp, window_id, which, x, y, direction, mouse_x, mouse_y, integer_x, integer_y), offset: 0 }
}

///|
extern "c" fn mousewheelevent_layout_ffi() -> FixedArray[Int32] = "moonbit_sdl_mousewheelevent_layout"

///|
let mousewheelevent_layout : FixedArray[Int32] = mousewheelevent_layout_ffi()

///|
/// View exactly the structure bytes without copying; writes and native buffer reuse are shared.
pub fn MouseWheelEvent::as_bytes(self : Self) -> BytesView {
  self.bytes.exact_view(start=self.offset, end=self.offset + mousewheelevent_layout[0])
}

///|
/// Copy the structure bytes into independent storage. Native pointers remain shallow copies.
pub fn MouseWheelEvent::copy(self : Self) -> Self {
  { bytes: value_copy_bytes(self.bytes, self.offset, mousewheelevent_layout[0]), offset: 0 }
}

///|
pub fn MouseWheelEvent::type_(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousewheelevent_layout[1], mousewheelevent_layout[2], mousewheelevent_layout[3] != 0, value_little_endian)
}

///|
pub fn MouseWheelEvent::reserved(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousewheelevent_layout[4], mousewheelevent_layout[5], mousewheelevent_layout[6] != 0, value_little_endian)
}

///|
pub fn MouseWheelEvent::timestamp(self : Self) -> UInt64 {
  read_integer(self.bytes, self.offset + mousewheelevent_layout[7], mousewheelevent_layout[8], mousewheelevent_layout[9] != 0, value_little_endian)
}

///|
pub fn MouseWheelEvent::window_id(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousewheelevent_layout[10], mousewheelevent_layout[11], mousewheelevent_layout[12] != 0, value_little_endian)
}

///|
pub fn MouseWheelEvent::which(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousewheelevent_layout[13], mousewheelevent_layout[14], mousewheelevent_layout[15] != 0, value_little_endian)
}

///|
pub fn MouseWheelEvent::x(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousewheelevent_layout[16], mousewheelevent_layout[17], value_little_endian)
}

///|
pub fn MouseWheelEvent::y(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousewheelevent_layout[19], mousewheelevent_layout[20], value_little_endian)
}

///|
pub fn MouseWheelEvent::direction(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + mousewheelevent_layout[22], mousewheelevent_layout[23], mousewheelevent_layout[24] != 0, value_little_endian)
}

///|
pub fn MouseWheelEvent::mouse_x(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousewheelevent_layout[25], mousewheelevent_layout[26], value_little_endian)
}

///|
pub fn MouseWheelEvent::mouse_y(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + mousewheelevent_layout[28], mousewheelevent_layout[29], value_little_endian)
}

///|
pub fn MouseWheelEvent::integer_x(self : Self) -> Int32 {
  read_integer(self.bytes, self.offset + mousewheelevent_layout[31], mousewheelevent_layout[32], mousewheelevent_layout[33] != 0, value_little_endian)
}

///|
pub fn MouseWheelEvent::integer_y(self : Self) -> Int32 {
  read_integer(self.bytes, self.offset + mousewheelevent_layout[34], mousewheelevent_layout[35], mousewheelevent_layout[36] != 0, value_little_endian)
}

///|
pub fn MouseWheelEvent::set_type(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[1], mousewheelevent_layout[2], value.to_uint64())
}

///|
pub fn MouseWheelEvent::set_reserved(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[4], mousewheelevent_layout[5], value.to_uint64())
}

///|
pub fn MouseWheelEvent::set_timestamp(self : Self, value : UInt64) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[7], mousewheelevent_layout[8], value)
}

///|
pub fn MouseWheelEvent::set_window_id(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[10], mousewheelevent_layout[11], value.to_uint64())
}

///|
pub fn MouseWheelEvent::set_which(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[13], mousewheelevent_layout[14], value.to_uint64())
}

///|
pub fn MouseWheelEvent::set_x(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[16], mousewheelevent_layout[17], value.reinterpret_as_uint().to_uint64())
}

///|
pub fn MouseWheelEvent::set_y(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[19], mousewheelevent_layout[20], value.reinterpret_as_uint().to_uint64())
}

///|
pub fn MouseWheelEvent::set_direction(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[22], mousewheelevent_layout[23], value.to_uint64())
}

///|
pub fn MouseWheelEvent::set_mouse_x(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[25], mousewheelevent_layout[26], value.reinterpret_as_uint().to_uint64())
}

///|
pub fn MouseWheelEvent::set_mouse_y(self : Self, value : Float) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[28], mousewheelevent_layout[29], value.reinterpret_as_uint().to_uint64())
}

///|
pub fn MouseWheelEvent::set_integer_x(self : Self, value : Int32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[31], mousewheelevent_layout[32], Int64::from_int(value).reinterpret_as_uint64())
}

///|
pub fn MouseWheelEvent::set_integer_y(self : Self, value : Int32) -> Unit {
  value_write_bits(self.bytes, self.offset + mousewheelevent_layout[34], mousewheelevent_layout[35], Int64::from_int(value).reinterpret_as_uint64())
}

///|
struct Event {
  bytes : Bytes
  offset : Int32
}

///|
extern "c" fn event_make() -> Bytes = "moonbit_sdl_event_make"

///|
pub fn Event::Event() -> Event {
  { bytes: event_make(), offset: 0 }
}

///|
extern "c" fn event_layout_ffi() -> FixedArray[Int32] = "moonbit_sdl_event_layout"

///|
let event_layout : FixedArray[Int32] = event_layout_ffi()

///|
/// View exactly the structure bytes without copying; writes and native buffer reuse are shared.
pub fn Event::as_bytes(self : Self) -> BytesView {
  self.bytes.exact_view(start=self.offset, end=self.offset + event_layout[0])
}

///|
/// Copy the structure bytes into independent storage. Native pointers remain shallow copies.
pub fn Event::copy(self : Self) -> Self {
  { bytes: value_copy_bytes(self.bytes, self.offset, event_layout[0]), offset: 0 }
}

///|
pub fn Event::event_type(self : Self) -> UInt32 {
  read_integer(self.bytes, self.offset + event_layout[1], event_layout[2], event_layout[3] != 0, value_little_endian)
}

///|
/// A view into the original buffer; writes and native buffer reuse are shared.
pub fn Event::window(self : Self) -> WindowEvent {
  { bytes: self.bytes, offset: self.offset + event_layout[4] }
}

///|
/// A view into the original buffer; writes and native buffer reuse are shared.
pub fn Event::key(self : Self) -> KeyboardEvent {
  { bytes: self.bytes, offset: self.offset + event_layout[7] }
}

///|
/// A view into the original buffer; writes and native buffer reuse are shared.
pub fn Event::text(self : Self) -> TextInputEvent {
  { bytes: self.bytes, offset: self.offset + event_layout[10] }
}

///|
/// A view into the original buffer; writes and native buffer reuse are shared.
pub fn Event::motion(self : Self) -> MouseMotionEvent {
  { bytes: self.bytes, offset: self.offset + event_layout[13] }
}

///|
/// A view into the original buffer; writes and native buffer reuse are shared.
pub fn Event::button(self : Self) -> MouseButtonEvent {
  { bytes: self.bytes, offset: self.offset + event_layout[16] }
}

///|
/// A view into the original buffer; writes and native buffer reuse are shared.
pub fn Event::wheel(self : Self) -> MouseWheelEvent {
  { bytes: self.bytes, offset: self.offset + event_layout[19] }
}

///|
pub fn Event::set_event_type(self : Self, value : UInt32) -> Unit {
  value_write_bits(self.bytes, self.offset + event_layout[1], event_layout[2], value.to_uint64())
}

///|
pub const EVENT_FIRST : UInt32 = 0

///|
pub const EVENT_QUIT : UInt32 = 0x100

///|
pub const EVENT_TERMINATING : UInt32 = 257

///|
pub const EVENT_LOW_MEMORY : UInt32 = 258

///|
pub const EVENT_WILL_ENTER_BACKGROUND : UInt32 = 259

///|
pub const EVENT_DID_ENTER_BACKGROUND : UInt32 = 260

///|
pub const EVENT_WILL_ENTER_FOREGROUND : UInt32 = 261

///|
pub const EVENT_DID_ENTER_FOREGROUND : UInt32 = 262

///|
pub const EVENT_LOCALE_CHANGED : UInt32 = 263

///|
pub const EVENT_SYSTEM_THEME_CHANGED : UInt32 = 264

///|
pub const EVENT_DISPLAY_ORIENTATION : UInt32 = 0x151

///|
pub const EVENT_DISPLAY_ADDED : UInt32 = 338

///|
pub const EVENT_DISPLAY_REMOVED : UInt32 = 339

///|
pub const EVENT_DISPLAY_MOVED : UInt32 = 340

///|
pub const EVENT_DISPLAY_DESKTOP_MODE_CHANGED : UInt32 = 341

///|
pub const EVENT_DISPLAY_CURRENT_MODE_CHANGED : UInt32 = 342

///|
pub const EVENT_DISPLAY_CONTENT_SCALE_CHANGED : UInt32 = 343

///|
pub const EVENT_DISPLAY_USABLE_BOUNDS_CHANGED : UInt32 = 344

///|
pub const EVENT_WINDOW_SHOWN : UInt32 = 0x202

///|
pub const EVENT_WINDOW_HIDDEN : UInt32 = 515

///|
pub const EVENT_WINDOW_EXPOSED : UInt32 = 516

///|
pub const EVENT_WINDOW_MOVED : UInt32 = 517

///|
pub const EVENT_WINDOW_RESIZED : UInt32 = 518

///|
pub const EVENT_WINDOW_PIXEL_SIZE_CHANGED : UInt32 = 519

///|
pub const EVENT_WINDOW_METAL_VIEW_RESIZED : UInt32 = 520

///|
pub const EVENT_WINDOW_MINIMIZED : UInt32 = 521

///|
pub const EVENT_WINDOW_MAXIMIZED : UInt32 = 522

///|
pub const EVENT_WINDOW_RESTORED : UInt32 = 523

///|
pub const EVENT_WINDOW_MOUSE_ENTER : UInt32 = 524

///|
pub const EVENT_WINDOW_MOUSE_LEAVE : UInt32 = 525

///|
pub const EVENT_WINDOW_FOCUS_GAINED : UInt32 = 526

///|
pub const EVENT_WINDOW_FOCUS_LOST : UInt32 = 527

///|
pub const EVENT_WINDOW_CLOSE_REQUESTED : UInt32 = 528

///|
pub const EVENT_WINDOW_HIT_TEST : UInt32 = 529

///|
pub const EVENT_WINDOW_ICCPROF_CHANGED : UInt32 = 530

///|
pub const EVENT_WINDOW_DISPLAY_CHANGED : UInt32 = 531

///|
pub const EVENT_WINDOW_DISPLAY_SCALE_CHANGED : UInt32 = 532

///|
pub const EVENT_WINDOW_SAFE_AREA_CHANGED : UInt32 = 533

///|
pub const EVENT_WINDOW_OCCLUDED : UInt32 = 534

///|
pub const EVENT_WINDOW_ENTER_FULLSCREEN : UInt32 = 535

///|
pub const EVENT_WINDOW_LEAVE_FULLSCREEN : UInt32 = 536

///|
pub const EVENT_WINDOW_DESTROYED : UInt32 = 537

///|
pub const EVENT_WINDOW_HDR_STATE_CHANGED : UInt32 = 538

///|
pub const EVENT_KEY_DOWN : UInt32 = 0x300

///|
pub const EVENT_KEY_UP : UInt32 = 769

///|
pub const EVENT_TEXT_EDITING : UInt32 = 770

///|
pub const EVENT_TEXT_INPUT : UInt32 = 771

///|
pub const EVENT_KEYMAP_CHANGED : UInt32 = 772

///|
pub const EVENT_KEYBOARD_ADDED : UInt32 = 773

///|
pub const EVENT_KEYBOARD_REMOVED : UInt32 = 774

///|
pub const EVENT_TEXT_EDITING_CANDIDATES : UInt32 = 775

///|
pub const EVENT_SCREEN_KEYBOARD_SHOWN : UInt32 = 776

///|
pub const EVENT_SCREEN_KEYBOARD_HIDDEN : UInt32 = 777

///|
pub const EVENT_MOUSE_MOTION : UInt32 = 0x400

///|
pub const EVENT_MOUSE_BUTTON_DOWN : UInt32 = 1025

///|
pub const EVENT_MOUSE_BUTTON_UP : UInt32 = 1026

///|
pub const EVENT_MOUSE_WHEEL : UInt32 = 1027

///|
pub const EVENT_MOUSE_ADDED : UInt32 = 1028

///|
pub const EVENT_MOUSE_REMOVED : UInt32 = 1029

///|
pub const EVENT_JOYSTICK_AXIS_MOTION : UInt32 = 0x600

///|
pub const EVENT_JOYSTICK_BALL_MOTION : UInt32 = 1537

///|
pub const EVENT_JOYSTICK_HAT_MOTION : UInt32 = 1538

///|
pub const EVENT_JOYSTICK_BUTTON_DOWN : UInt32 = 1539

///|
pub const EVENT_JOYSTICK_BUTTON_UP : UInt32 = 1540

///|
pub const EVENT_JOYSTICK_ADDED : UInt32 = 1541

///|
pub const EVENT_JOYSTICK_REMOVED : UInt32 = 1542

///|
pub const EVENT_JOYSTICK_BATTERY_UPDATED : UInt32 = 1543

///|
pub const EVENT_JOYSTICK_UPDATE_COMPLETE : UInt32 = 1544

///|
pub const EVENT_GAMEPAD_AXIS_MOTION : UInt32 = 0x650

///|
pub const EVENT_GAMEPAD_BUTTON_DOWN : UInt32 = 1617

///|
pub const EVENT_GAMEPAD_BUTTON_UP : UInt32 = 1618

///|
pub const EVENT_GAMEPAD_ADDED : UInt32 = 1619

///|
pub const EVENT_GAMEPAD_REMOVED : UInt32 = 1620

///|
pub const EVENT_GAMEPAD_REMAPPED : UInt32 = 1621

///|
pub const EVENT_GAMEPAD_TOUCHPAD_DOWN : UInt32 = 1622

///|
pub const EVENT_GAMEPAD_TOUCHPAD_MOTION : UInt32 = 1623

///|
pub const EVENT_GAMEPAD_TOUCHPAD_UP : UInt32 = 1624

///|
pub const EVENT_GAMEPAD_SENSOR_UPDATE : UInt32 = 1625

///|
pub const EVENT_GAMEPAD_UPDATE_COMPLETE : UInt32 = 1626

///|
pub const EVENT_GAMEPAD_STEAM_HANDLE_UPDATED : UInt32 = 1627

///|
pub const EVENT_FINGER_DOWN : UInt32 = 0x700

///|
pub const EVENT_FINGER_UP : UInt32 = 1793

///|
pub const EVENT_FINGER_MOTION : UInt32 = 1794

///|
pub const EVENT_FINGER_CANCELED : UInt32 = 1795

///|
pub const EVENT_PINCH_BEGIN : UInt32 = 0x710

///|
pub const EVENT_PINCH_UPDATE : UInt32 = 1809

///|
pub const EVENT_PINCH_END : UInt32 = 1810

///|
pub const EVENT_CLIPBOARD_UPDATE : UInt32 = 0x900

///|
pub const EVENT_DROP_FILE : UInt32 = 0x1000

///|
pub const EVENT_DROP_TEXT : UInt32 = 4097

///|
pub const EVENT_DROP_BEGIN : UInt32 = 4098

///|
pub const EVENT_DROP_COMPLETE : UInt32 = 4099

///|
pub const EVENT_DROP_POSITION : UInt32 = 4100

///|
pub const EVENT_AUDIO_DEVICE_ADDED : UInt32 = 0x1100

///|
pub const EVENT_AUDIO_DEVICE_REMOVED : UInt32 = 4353

///|
pub const EVENT_AUDIO_DEVICE_FORMAT_CHANGED : UInt32 = 4354

///|
pub const EVENT_SENSOR_UPDATE : UInt32 = 0x1200

///|
pub const EVENT_PEN_PROXIMITY_IN : UInt32 = 0x1300

///|
pub const EVENT_PEN_PROXIMITY_OUT : UInt32 = 4865

///|
pub const EVENT_PEN_DOWN : UInt32 = 4866

///|
pub const EVENT_PEN_UP : UInt32 = 4867

///|
pub const EVENT_PEN_BUTTON_DOWN : UInt32 = 4868

///|
pub const EVENT_PEN_BUTTON_UP : UInt32 = 4869

///|
pub const EVENT_PEN_MOTION : UInt32 = 4870

///|
pub const EVENT_PEN_AXIS : UInt32 = 4871

///|
pub const EVENT_CAMERA_DEVICE_ADDED : UInt32 = 0x1400

///|
pub const EVENT_CAMERA_DEVICE_REMOVED : UInt32 = 5121

///|
pub const EVENT_CAMERA_DEVICE_APPROVED : UInt32 = 5122

///|
pub const EVENT_CAMERA_DEVICE_DENIED : UInt32 = 5123

///|
pub const EVENT_RENDER_TARGETS_RESET : UInt32 = 0x2000

///|
pub const EVENT_RENDER_DEVICE_RESET : UInt32 = 8193

///|
pub const EVENT_RENDER_DEVICE_LOST : UInt32 = 8194

///|
pub const EVENT_PRIVATE0 : UInt32 = 0x4000

///|
pub const EVENT_PRIVATE1 : UInt32 = 16385

///|
pub const EVENT_PRIVATE2 : UInt32 = 16386

///|
pub const EVENT_PRIVATE3 : UInt32 = 16387

///|
pub const EVENT_POLL_SENTINEL : UInt32 = 0x7F00

///|
pub const EVENT_USER : UInt32 = 0x8000

///|
pub const EVENT_LAST : UInt32 = 0xFFFF

///|
pub const EVENT_ENUM_PADDING : UInt32 = 0x7FFFFFFF

///|
#borrow(event)
extern "c" fn poll_event_ffi(event : Bytes, event_offset : Int32) -> Bool = "moonbit_sdl_poll_event_ffi"

///|
pub fn poll_event(event : Event) -> Bool {
  poll_event_ffi(event.bytes, event.offset)
}

///|
#borrow(event)
extern "c" fn wait_event_timeout_ffi(event : Bytes, event_offset : Int32, timeoutMS : Int32) -> Bool = "moonbit_sdl_wait_event_timeout_ffi"

///|
pub fn wait_event_timeout(event : Event, timeoutMS : Int32) -> Bool {
  wait_event_timeout_ffi(event.bytes, event.offset, timeoutMS)
}

///|
#borrow(event)
extern "c" fn push_event_ffi(event : Bytes, event_offset : Int32) -> Bool = "moonbit_sdl_push_event_ffi"

///|
pub fn push_event(event : Event) -> Bool {
  push_event_ffi(event.bytes, event.offset)
}

///|
pub extern "c" fn register_events(numevents : Int32) -> UInt32 = "moonbit_sdl_register_events"
