///|
pub using @sys {MESSAGEBOX_ERROR, MESSAGEBOX_WARNING, MESSAGEBOX_INFORMATION}

///|
pub fn Window::show_simple_message_box(
  self : Self,
  title~ : String,
  message~ : String,
  flags? : UInt = MESSAGEBOX_INFORMATION,
) -> Unit raise SdlError {
  check_ok(
    @sys.show_simple_message_box(
      flags,
      @utf8.encode(title),
      @utf8.encode(message),
      self.raw(),
    ),
    "SDL_ShowSimpleMessageBox",
  )
}
