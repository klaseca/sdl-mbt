///|
fn with_event_window(test_window : (@sys.Window) -> Unit raise) -> Unit raise {
  let driver = @env.get_env_var("SDL_VIDEODRIVER")
  @env.set_env_var("SDL_VIDEODRIVER", "dummy")
  defer (fn() {
    match driver {
      Some(driver) => @env.set_env_var("SDL_VIDEODRIVER", driver)
      None => @env.unset_env_var("SDL_VIDEODRIVER")
    }
  })()
  assert_true(@sys.init_lib(@sys.INIT_VIDEO))
  defer @sys.quit()
  let window = @sys.create_window(
    b"Event watch test",
    160,
    80,
    @sys.WINDOW_HIDDEN,
  )
  assert_false(window.is_null())
  defer @sys.destroy_window(window)
  test_window(window)
}

///|
let call_watch : FuncRef[((Bytes) -> Unit, Bytes) -> Unit] = fn(
  callback,
  bytes,
) {
  callback(bytes)
}

///|
test "event watch registration requires SDL initialization" {
  let calls = Ref(0)
  let watch = @sys.add_event_watch(call_watch, fn(_) { calls.val += 1 })
  assert_true(watch.is_null())
  @sys.remove_event_watch(watch)
  @sys.remove_event_watch(watch)
  assert_eq(calls.val, 0)
}

///|
test "event watches deliver ordered resize events and retain their bytes" {
  with_event_window(window => {
    let window_id = @sys.get_window_id(window)
    let observed : Array[(String, Int32, Int32)] = []
    let retained : Array[Bytes] = []
    let first = @sys.add_event_watch(call_watch, fn(bytes) {
      let event = @sys.Event::from_bytes(bytes)
      if event.event_type() == @sys.EVENT_WINDOW_RESIZED &&
        event.window_window_id() == window_id {
        observed.push(("first", event.window_data1(), event.window_data2()))
        retained.push(bytes)
      }
    })
    assert_false(first.is_null())
    defer @sys.remove_event_watch(first)
    let second = @sys.add_event_watch(call_watch, fn(bytes) {
      let event = @sys.Event::from_bytes(bytes)
      if event.event_type() == @sys.EVENT_WINDOW_RESIZED &&
        event.window_window_id() == window_id {
        observed.push(("second", event.window_data1(), event.window_data2()))
      }
    })
    assert_false(second.is_null())
    defer @sys.remove_event_watch(second)
    assert_true(@sys.set_window_size(window, 180, 90))
    assert_true(@sys.set_window_size(window, 170, 85))
    assert_eq(observed, [
      ("first", 180, 90),
      ("second", 180, 90),
      ("first", 170, 85),
      ("second", 170, 85),
    ])
    @sys.remove_event_watch(first)
    @sys.remove_event_watch(first)
    assert_true(first.is_null())
    assert_true(@sys.set_window_size(window, 190, 95))
    assert_eq(observed.length(), 5)
    assert_eq(observed[4], ("second", 190, 95))
    let sizes = retained.map(fn(bytes) {
      let event = @sys.Event::from_bytes(bytes)
      (event.window_data1(), event.window_data2())
    })
    assert_eq(sizes, [(180, 90), (170, 85)])
    let event = @sys.Event()
    while @sys.poll_event(event) {
      ()
    }
    assert_eq(observed.length(), 5)
  })
}

///|
test "an event watch can remove itself from its callback" {
  with_event_window(window => {
    let handle : Ref[@sys.EventWatch?] = Ref(None)
    let calls = Ref(0)
    let watch = @sys.add_event_watch(call_watch, fn(bytes) {
      if @sys.Event::from_bytes(bytes).event_type() == @sys.EVENT_WINDOW_RESIZED {
        calls.val += 1
        if handle.val is Some(watch) {
          handle.val = None
          @sys.remove_event_watch(watch)
        }
      }
    })
    assert_false(watch.is_null())
    defer @sys.remove_event_watch(watch)
    handle.val = Some(watch)
    assert_true(@sys.set_window_size(window, 180, 90))
    assert_true(watch.is_null())
    assert_true(@sys.set_window_size(window, 170, 85))
    assert_eq(calls.val, 1)
  })
}
