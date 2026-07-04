// Generated file. Do not edit by hand.

///|
struct FRect {
  bytes : Bytes
}

///|
extern "c" fn f_rect_make(x : Float, y : Float, w : Float, h : Float) -> Bytes = "moonbit_sdl_f_rect_make"

///|
pub fn FRect::FRect(x : Float, y : Float, w : Float, h : Float) -> FRect {
  { bytes: f_rect_make(x, y, w, h) }
}

///|
pub fn FRect::to_bytes(self : Self) -> Bytes {
  self.bytes
}

///|
struct Rect {
  bytes : Bytes
}

///|
extern "c" fn rect_make(x : Int, y : Int, w : Int, h : Int) -> Bytes = "moonbit_sdl_rect_make"

///|
pub fn Rect::Rect(x : Int, y : Int, w : Int, h : Int) -> Rect {
  { bytes: rect_make(x, y, w, h) }
}

///|
pub fn Rect::to_bytes(self : Self) -> Bytes {
  self.bytes
}
