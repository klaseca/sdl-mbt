// Generated file. Do not edit by hand.

///|
#external
pub type Cursor

///|
pub fn Cursor::to_pointer(self : Self) -> Pointer = "%identity"

///|
pub fn Cursor::is_null(self : Self) -> Bool {
  self.to_pointer().is_null()
}

///|
pub const MOUSEWHEEL_NORMAL : UInt32 = 0

///|
pub const MOUSEWHEEL_FLIPPED : UInt32 = 1
