///|
fn with_event_window(test_window : (@sdl.Window) -> Unit raise) -> Unit raise {
  let driver = @env.get_env_var("SDL_VIDEODRIVER")
  @env.set_env_var("SDL_VIDEODRIVER", "dummy")
  defer (fn() {
    match driver {
      Some(driver) => @env.set_env_var("SDL_VIDEODRIVER", driver)
      None => @env.unset_env_var("SDL_VIDEODRIVER")
    }
  })()
  @sdl.init_lib(@sdl.INIT_VIDEO)
  defer @sdl.quit()
  let window = @sdl.Window(
    title="Window listener test",
    width=160,
    height=80,
    hidden=true,
  )
  defer window.destroy()
  test_window(window)
}

///|
test "window listeners route resize events and sizes to their own window" {
  with_event_window(window => {
    let other = @sdl.Window(
      title="Other window",
      width=160,
      height=80,
      hidden=true,
    )
    defer other.destroy()
    let observed : Array[@sdl.WindowEvent] = []
    let listeners : Array[@sdl.EventListener] = []
    defer (fn() {
      for listener in listeners {
        listener.dispose()
      }
    })()
    for name in [@sdl.Resized, @sdl.PixelSizeChanged] {
      listeners.push(window.on(name, fn(event) { observed.push(event) }))
    }
    other.set_size(width=200, height=100)
    assert_eq(observed.length(), 0)
    window.set_size(width=180, height=90)
    let window_id = window.id()
    assert_eq(observed, [
      @sdl.WindowEvent::{
        window_id,
        name: @sdl.Resized,
        size: Some(@sdl.Size::{ width: 180, height: 90, }),
      },
      @sdl.WindowEvent::{
        window_id,
        name: @sdl.PixelSizeChanged,
        size: Some(@sdl.Size::{ width: 180, height: 90, }),
      },
    ])
    while @sdl.poll_event() is Some(_) {
      ()
    }
    assert_eq(observed.length(), 2)
  })
}

///|
test "disposing a window listener stops delivery and leaves other listeners active" {
  with_event_window(window => {
    let old_calls = Ref(0)
    let listener = window.on(@sdl.Resized, fn(_) { old_calls.val += 1 })
    defer listener.dispose()
    window.set_size(width=180, height=90)
    assert_eq(old_calls.val, 1)
    listener.dispose()
    listener.dispose()
    let new_calls = Ref(0)
    let replacement = window.on(@sdl.Resized, fn(_) { new_calls.val += 1 })
    defer replacement.dispose()
    window.set_size(width=170, height=85)
    assert_eq(old_calls.val, 1)
    assert_eq(new_calls.val, 1)
  })
}
