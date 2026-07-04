// Generated file. Do not edit by hand.

///|
pub const MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT : UInt = 0x00000080

///|
pub const MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT : UInt = 0x00000100

///|
pub const MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT : UInt = 0x00000002

///|
pub const MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT : UInt = 0x00000001

///|
pub const MESSAGEBOX_COLOR_BACKGROUND : UInt = 0

///|
pub const MESSAGEBOX_COLOR_BUTTON_BACKGROUND : UInt = 3

///|
pub const MESSAGEBOX_COLOR_BUTTON_BORDER : UInt = 2

///|
pub const MESSAGEBOX_COLOR_BUTTON_SELECTED : UInt = 4

///|
pub const MESSAGEBOX_COLOR_COUNT : UInt = 5

///|
pub const MESSAGEBOX_COLOR_TEXT : UInt = 1

///|
pub const MESSAGEBOX_ERROR : UInt = 0x00000010

///|
pub const MESSAGEBOX_INFORMATION : UInt = 0x00000040

///|
pub const MESSAGEBOX_WARNING : UInt = 0x00000020

///|
#borrow(title, message, window)
pub extern "c" fn show_simple_message_box(flags : UInt, title : Bytes, message : Bytes, window : Window) -> Bool = "moonbit_sdl_show_simple_message_box"
