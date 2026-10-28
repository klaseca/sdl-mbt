// Generated file. Do not edit by hand.

///|
struct Rect {
  bytes : Bytes
  offset : Int32
}

///|
extern "c" fn rect_make(x : Int32, y : Int32, w : Int32, h : Int32) -> Bytes = "moonbit_sdl_rect_make"

///|
pub fn Rect::Rect(x : Int32, y : Int32, w : Int32, h : Int32) -> Rect {
  { bytes: rect_make(x, y, w, h), offset: 0 }
}

///|
extern "c" fn rect_layout_ffi() -> FixedArray[Int32] = "moonbit_sdl_rect_layout"

///|
let rect_layout : FixedArray[Int32] = rect_layout_ffi()

///|
/// View exactly the structure bytes without copying; writes and native buffer reuse are shared.
pub fn Rect::as_bytes(self : Self) -> BytesView {
  self.bytes.exact_view(start=self.offset, end=self.offset + rect_layout[0])
}

///|
/// Copy the structure bytes into independent storage. Native pointers remain shallow copies.
pub fn Rect::copy(self : Self) -> Self {
  { bytes: value_copy_bytes(self.bytes, self.offset, rect_layout[0]), offset: 0 }
}

///|
pub fn Rect::x(self : Self) -> Int32 {
  read_integer(self.bytes, self.offset + rect_layout[1], rect_layout[2], rect_layout[3] != 0, value_little_endian)
}

///|
pub fn Rect::y(self : Self) -> Int32 {
  read_integer(self.bytes, self.offset + rect_layout[4], rect_layout[5], rect_layout[6] != 0, value_little_endian)
}

///|
pub fn Rect::w(self : Self) -> Int32 {
  read_integer(self.bytes, self.offset + rect_layout[7], rect_layout[8], rect_layout[9] != 0, value_little_endian)
}

///|
pub fn Rect::h(self : Self) -> Int32 {
  read_integer(self.bytes, self.offset + rect_layout[10], rect_layout[11], rect_layout[12] != 0, value_little_endian)
}

///|
struct FRect {
  bytes : Bytes
  offset : Int32
}

///|
extern "c" fn frect_make(x : Float, y : Float, w : Float, h : Float) -> Bytes = "moonbit_sdl_frect_make"

///|
pub fn FRect::FRect(x : Float, y : Float, w : Float, h : Float) -> FRect {
  { bytes: frect_make(x, y, w, h), offset: 0 }
}

///|
extern "c" fn frect_layout_ffi() -> FixedArray[Int32] = "moonbit_sdl_frect_layout"

///|
let frect_layout : FixedArray[Int32] = frect_layout_ffi()

///|
/// View exactly the structure bytes without copying; writes and native buffer reuse are shared.
pub fn FRect::as_bytes(self : Self) -> BytesView {
  self.bytes.exact_view(start=self.offset, end=self.offset + frect_layout[0])
}

///|
/// Copy the structure bytes into independent storage. Native pointers remain shallow copies.
pub fn FRect::copy(self : Self) -> Self {
  { bytes: value_copy_bytes(self.bytes, self.offset, frect_layout[0]), offset: 0 }
}

///|
pub fn FRect::x(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + frect_layout[1], frect_layout[2], value_little_endian)
}

///|
pub fn FRect::y(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + frect_layout[4], frect_layout[5], value_little_endian)
}

///|
pub fn FRect::w(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + frect_layout[7], frect_layout[8], value_little_endian)
}

///|
pub fn FRect::h(self : Self) -> Float {
  value_read_float(self.bytes, self.offset + frect_layout[10], frect_layout[11], value_little_endian)
}
