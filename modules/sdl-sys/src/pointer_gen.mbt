// Generated file. Do not edit by hand.

///|
#external
pub type Pointer

///|
#borrow(pointer)
extern "c" fn pointer_is_null(pointer : Pointer) -> Bool = "moonbit_sdl_pointer_is_null"

///|
pub fn Pointer::is_null(self : Self) -> Bool {
  pointer_is_null(self)
}
