///|
test "nested SDL event accessors share their parent buffer and copies isolate it" {
  let event = @sys.Event()
  event.set_event_type(@sys.EVENT_WINDOW_RESIZED)
  let window = event.window()
  window.set_window_id(42)
  window.set_data1(800)
  window.set_data2(600)
  assert_eq(event.event_type(), @sys.EVENT_WINDOW_RESIZED)
  assert_eq(event.window().window_id(), 42)
  assert_eq(event.window().data1(), 800)
  let bytes = window.as_bytes()
  assert_true(bytes.length() < event.as_bytes().length())
  let snapshot = window.copy()
  event.window().set_data1(1024)
  assert_eq(window.data1(), 1024)
  assert_eq(snapshot.data1(), 800)
  assert_eq(bytes, window.as_bytes())
  assert_false(bytes == snapshot.as_bytes())
  let retained = {
    let source = @sys.Event()
    source.window().set_window_id(123)
    source.window()
  }
  assert_eq(retained.window_id(), 123)
}

///|
test "different typed SDL union members use the same event storage" {
  let event = @sys.Event()
  event.set_event_type(@sys.EVENT_MOUSE_WHEEL)
  let wheel = event.wheel()
  wheel.set_window_id(7)
  wheel.set_x(0.5)
  wheel.set_y(-1.25)
  assert_eq(event.wheel().window_id(), 7)
  assert_eq(event.wheel().x(), 0.5)
  assert_eq(event.wheel().y(), -1.25)
  let snapshot = event.copy()
  // Reusing the buffer changes the retained view as well.
  event.window().set_window_id(9)
  assert_eq(wheel.window_id(), 9)
  assert_eq(snapshot.wheel().window_id(), 7)
}
