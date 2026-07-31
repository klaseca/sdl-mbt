// Generated file. Do not edit by hand.

///|
pub const PROP_TEXTINPUT_TYPE_NUMBER : Bytes = b"SDL.textinput.type"

///|
pub const PROP_TEXTINPUT_CAPITALIZATION_NUMBER : Bytes = b"SDL.textinput.capitalization"

///|
pub const PROP_TEXTINPUT_AUTOCORRECT_BOOLEAN : Bytes = b"SDL.textinput.autocorrect"

///|
pub const PROP_TEXTINPUT_MULTILINE_BOOLEAN : Bytes = b"SDL.textinput.multiline"

///|
pub const PROP_TEXTINPUT_ANDROID_INPUTTYPE_NUMBER : Bytes = b"SDL.textinput.android.inputtype"

///|
#borrow(window)
pub extern "c" fn start_text_input(window : Window) -> Bool = "moonbit_sdl_start_text_input"

///|
#borrow(window)
pub extern "c" fn stop_text_input(window : Window) -> Bool = "moonbit_sdl_stop_text_input"
