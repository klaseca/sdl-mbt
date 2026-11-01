///|
test "window reports display scale and pixel density separately" {
  with_event_window(window => {
    assert_eq(window.display_scale(), 1.0)
    assert_eq(window.pixel_density(), 1.0)
  })
}

///|
test "display scale listeners retain window routing without a resize payload" {
  with_event_window(window => {
    while @sdl.poll_event() is Some(_) {
      ()
    }
    let observed : Array[@sdl.WindowEvent] = []
    let listener = window.on(@sdl.DisplayScaleChanged, event => {
      observed.push(event)
    })
    defer listener.dispose()
    let event = @sys.Event()
    event.set_event_type(@sys.EVENT_WINDOW_DISPLAY_SCALE_CHANGED)
    event.window().set_window_id(window.id() + 1)
    assert_true(@sys.push_event(event))
    assert_eq(observed.length(), 0)
    assert_true(@sdl.poll_event() is Some(@sdl.WindowDisplayScaleChanged(_)))
    while @sdl.poll_event() is Some(_) {
      ()
    }
    event.window().set_window_id(window.id())
    assert_true(@sys.push_event(event))
    let expected = @sdl.WindowEvent::{
      window_id: window.id(),
      name: @sdl.DisplayScaleChanged,
      size: None,
    }
    assert_eq(observed, [expected])
    assert_eq(@sdl.poll_event(), Some(@sdl.WindowDisplayScaleChanged(expected)))
  })
}
