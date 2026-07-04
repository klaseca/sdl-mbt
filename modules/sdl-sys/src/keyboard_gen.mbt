// Generated file. Do not edit by hand.

///|
pub const PROP_TEXTINPUT_ANDROID_INPUTTYPE_NUMBER : Bytes = b"SDL.textinput.android.inputtype"

///|
pub const PROP_TEXTINPUT_AUTOCORRECT_BOOLEAN : Bytes = b"SDL.textinput.autocorrect"

///|
pub const PROP_TEXTINPUT_CAPITALIZATION_NUMBER : Bytes = b"SDL.textinput.capitalization"

///|
pub const PROP_TEXTINPUT_DEFAULT_TEXT_STRING : Bytes = b"SDL.textinput.default_text"

///|
pub const PROP_TEXTINPUT_MAX_LENGTH_NUMBER : Bytes = b"SDL.textinput.max_length"

///|
pub const PROP_TEXTINPUT_MULTILINE_BOOLEAN : Bytes = b"SDL.textinput.multiline"

///|
pub const PROP_TEXTINPUT_PLACEHOLDER_STRING : Bytes = b"SDL.textinput.placeholder"

///|
pub const PROP_TEXTINPUT_TITLE_STRING : Bytes = b"SDL.textinput.title"

///|
pub const PROP_TEXTINPUT_TYPE_NUMBER : Bytes = b"SDL.textinput.type"

///|
#borrow(window)
pub extern "c" fn start_text_input(window : Window) -> Bool = "moonbit_sdl_start_text_input"

///|
#borrow(window)
pub extern "c" fn stop_text_input(window : Window) -> Bool = "moonbit_sdl_stop_text_input"
