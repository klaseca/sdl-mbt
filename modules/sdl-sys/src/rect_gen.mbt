// Generated file. Do not edit by hand.

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

///|
#borrow(bytes)
extern "c" fn rect_x(bytes : Bytes) -> Int = "moonbit_sdl_rect_x"

///|
pub fn Rect::x(self : Self) -> Int {
  rect_x(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn rect_y(bytes : Bytes) -> Int = "moonbit_sdl_rect_y"

///|
pub fn Rect::y(self : Self) -> Int {
  rect_y(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn rect_w(bytes : Bytes) -> Int = "moonbit_sdl_rect_w"

///|
pub fn Rect::w(self : Self) -> Int {
  rect_w(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn rect_h(bytes : Bytes) -> Int = "moonbit_sdl_rect_h"

///|
pub fn Rect::h(self : Self) -> Int {
  rect_h(self.to_bytes())
}

///|
struct FRect {
  bytes : Bytes
}

///|
extern "c" fn frect_make(x : Float, y : Float, w : Float, h : Float) -> Bytes = "moonbit_sdl_frect_make"

///|
pub fn FRect::FRect(x : Float, y : Float, w : Float, h : Float) -> FRect {
  { bytes: frect_make(x, y, w, h) }
}

///|
pub fn FRect::to_bytes(self : Self) -> Bytes {
  self.bytes
}

///|
#borrow(bytes)
extern "c" fn frect_x(bytes : Bytes) -> Float = "moonbit_sdl_frect_x"

///|
pub fn FRect::x(self : Self) -> Float {
  frect_x(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn frect_y(bytes : Bytes) -> Float = "moonbit_sdl_frect_y"

///|
pub fn FRect::y(self : Self) -> Float {
  frect_y(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn frect_w(bytes : Bytes) -> Float = "moonbit_sdl_frect_w"

///|
pub fn FRect::w(self : Self) -> Float {
  frect_w(self.to_bytes())
}

///|
#borrow(bytes)
extern "c" fn frect_h(bytes : Bytes) -> Float = "moonbit_sdl_frect_h"

///|
pub fn FRect::h(self : Self) -> Float {
  frect_h(self.to_bytes())
}
