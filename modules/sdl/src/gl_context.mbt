///|
/// An OpenGL context owned by the creating UI thread. Dispose it before its
/// window; make it current before rendering or destroying graphics resources.
pub struct GlContext {
  priv raw : Ref[@sys.GLContext?]
  priv window : Window
}

///|
pub fn GlContext::GlContext(window : Window) -> GlContext raise SdlError {
  let raw = @sys.gl_create_context(window.raw())
  if raw.is_null() {
    raise_last_error("SDL_GL_CreateContext")
  }
  { raw: Ref(Some(raw)), window, }
}

///|
pub fn GlContext::make_current(self : Self) -> Unit raise SdlError {
  guard self.raw.val is Some(raw) else {
    raise SdlError("SDL_GL_MakeCurrent: context is destroyed")
  }
  check_ok(@sys.gl_make_current(self.window.raw(), raw), "SDL_GL_MakeCurrent")
}

///|
pub fn GlContext::destroy(self : Self) -> Unit raise SdlError {
  if self.raw.val is Some(raw) {
    check_ok(@sys.gl_destroy_context(raw), "SDL_GL_DestroyContext")
    self.raw.val = None
  }
}

///|
pub fn GlContext::set_swap_interval(
  self : Self,
  interval : Int32,
) -> Unit raise SdlError {
  self.make_current()
  check_ok(@sys.gl_set_swap_interval(interval), "SDL_GL_SetSwapInterval")
}

///|
pub fn GlContext::swap(self : Self) -> Unit raise SdlError {
  self.make_current()
  check_ok(@sys.gl_swap_window(self.window.raw()), "SDL_GL_SwapWindow")
}
