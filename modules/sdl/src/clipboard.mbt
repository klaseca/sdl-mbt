///|
pub type Clipboard

///|
pub fn Clipboard::set_text(text : String) -> Unit raise SdlError {
  check_ok(@sys.set_clipboard_text(@utf8.encode(text)), "SDL_SetClipboardText")
}

///|
pub fn Clipboard::text() -> String {
  @utf8.decode_lossy(@sys.get_clipboard_text())
}

///|
pub fn Clipboard::has_text() -> Bool {
  @sys.has_clipboard_text()
}
