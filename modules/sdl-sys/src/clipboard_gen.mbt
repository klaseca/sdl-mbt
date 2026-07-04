// Generated file. Do not edit by hand.

///|
#borrow(text)
pub extern "c" fn set_clipboard_text(text : Bytes) -> Bool = "moonbit_sdl_set_clipboard_text"

///|
pub extern "c" fn get_clipboard_text() -> Bytes = "moonbit_sdl_get_clipboard_text"

///|
pub extern "c" fn has_clipboard_text() -> Bool = "moonbit_sdl_has_clipboard_text"
