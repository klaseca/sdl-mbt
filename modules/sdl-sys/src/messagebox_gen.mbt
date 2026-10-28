// Generated file. Do not edit by hand.

///|
pub const MESSAGEBOX_ERROR : UInt32 = 0x00000010

///|
pub const MESSAGEBOX_WARNING : UInt32 = 0x00000020

///|
pub const MESSAGEBOX_INFORMATION : UInt32 = 0x00000040

///|
pub const MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT : UInt32 = 0x00000080

///|
pub const MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT : UInt32 = 0x00000100

///|
pub const MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT : UInt32 = 0x00000001

///|
pub const MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT : UInt32 = 0x00000002

///|
pub const MESSAGEBOX_COLOR_BACKGROUND : UInt32 = 0

///|
pub const MESSAGEBOX_COLOR_TEXT : UInt32 = 1

///|
pub const MESSAGEBOX_COLOR_BUTTON_BORDER : UInt32 = 2

///|
pub const MESSAGEBOX_COLOR_BUTTON_BACKGROUND : UInt32 = 3

///|
pub const MESSAGEBOX_COLOR_BUTTON_SELECTED : UInt32 = 4

///|
pub const MESSAGEBOX_COLOR_COUNT : UInt32 = 5

///|
#borrow(title, message, window)
pub extern "c" fn show_simple_message_box(flags : UInt32, title : Bytes, message : Bytes, window : Window) -> Bool = "moonbit_sdl_show_simple_message_box"
