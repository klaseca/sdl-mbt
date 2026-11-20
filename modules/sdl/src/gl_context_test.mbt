///|
test "OpenGL creation on a non-OpenGL window fails without destroying the window" {
  with_event_window(window => {
    let size = window.size()
    let rejected = try {
      let context = @sdl.GlContext(window)
      defer context.destroy()
      false
    } catch {
      @sdl.SdlError(_) => true
    }
    assert_true(rejected)
    assert_eq(window.size(), size)
  })
}
