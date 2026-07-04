///|
pub(all) struct KeyboardEvent {
  window_id : UInt
  keyboard_id : UInt
  scancode : Int
  keycode : UInt
  modifiers : UInt16
  repeat : Bool
} derive(Debug, Eq)

///|
pub(all) struct MouseMotionEvent {
  window_id : UInt
  mouse_id : UInt
  state : UInt
  x : Float
  y : Float
  xrel : Float
  yrel : Float
} derive(Debug, Eq)

///|
pub(all) struct MouseButtonEvent {
  window_id : UInt
  mouse_id : UInt
  button : Byte
  clicks : Byte
  x : Float
  y : Float
} derive(Debug, Eq)

///|
pub(all) struct WindowEvent {
  window_id : UInt
  name : WindowEventName
  size : Size?
} derive(Debug, Eq)

///|
pub(all) struct TextInputEvent {
  text : String
} derive(Debug, Eq)

///|
pub(all) enum WindowEventName {
  Exposed
  Resized
  PixelSizeChanged
  CloseRequested
} derive(Debug, Eq)

///|
pub(all) enum Event {
  Quit
  KeyDown(KeyboardEvent)
  KeyUp(KeyboardEvent)
  MouseMotion(MouseMotionEvent)
  MouseButtonDown(MouseButtonEvent)
  MouseButtonUp(MouseButtonEvent)
  TextInput(TextInputEvent)
  WindowExposed(WindowEvent)
  WindowResized(WindowEvent)
  WindowPixelSizeChanged(WindowEvent)
  WindowCloseRequested(WindowEvent)
  Other(UInt)
} derive(Debug, Eq)

///|
struct EventListener {
  raw : @sys.EventWatch
}

///|
let call_event_watch_callback : FuncRef[((Bytes) -> Unit, Bytes) -> Unit] = fn(
  callback,
  event,
) {
  callback(event)
}

///|
pub fn poll_event() -> Event? {
  let raw = @sys.Event()
  if @sys.poll_event(raw) {
    Some(Event::from_raw(raw))
  } else {
    None
  }
}

///|
fn wait_event_timeout(timeout_ms : Int) -> Event? {
  let raw = @sys.Event()
  if @sys.wait_event_timeout(raw, timeout_ms) {
    Some(Event::from_raw(raw))
  } else {
    None
  }
}

///|
fn Event::from_raw(raw : @sys.Event) -> Event {
  let event_type = raw.event_type()
  match event_type {
    @sys.EVENT_QUIT => Quit
    @sys.EVENT_KEY_DOWN => KeyDown(KeyboardEvent::from_raw(raw))
    @sys.EVENT_KEY_UP => KeyUp(KeyboardEvent::from_raw(raw))
    @sys.EVENT_MOUSE_MOTION => MouseMotion(MouseMotionEvent::from_raw(raw))
    @sys.EVENT_MOUSE_BUTTON_DOWN =>
      MouseButtonDown(MouseButtonEvent::from_raw(raw))
    @sys.EVENT_MOUSE_BUTTON_UP => MouseButtonUp(MouseButtonEvent::from_raw(raw))
    @sys.EVENT_TEXT_INPUT => TextInput(TextInputEvent::from_raw(raw))
    @sys.EVENT_WINDOW_EXPOSED =>
      WindowExposed(WindowEvent::from_raw(raw, Exposed))
    @sys.EVENT_WINDOW_RESIZED =>
      WindowResized(WindowEvent::from_raw(raw, Resized))
    @sys.EVENT_WINDOW_PIXEL_SIZE_CHANGED =>
      WindowPixelSizeChanged(WindowEvent::from_raw(raw, PixelSizeChanged))
    @sys.EVENT_WINDOW_CLOSE_REQUESTED =>
      WindowCloseRequested(WindowEvent::from_raw(raw, CloseRequested))
    _ => Other(event_type)
  }
}

///|
fn KeyboardEvent::from_raw(raw : @sys.Event) -> KeyboardEvent {
  {
    window_id: raw.key_window_id(),
    keyboard_id: raw.key_keyboard_id(),
    scancode: raw.key_scancode(),
    keycode: raw.key_keycode(),
    modifiers: raw.key_modifiers(),
    repeat: raw.key_repeat(),
  }
}

///|
fn MouseMotionEvent::from_raw(raw : @sys.Event) -> MouseMotionEvent {
  {
    window_id: raw.motion_window_id(),
    mouse_id: raw.motion_mouse_id(),
    state: raw.motion_state(),
    x: raw.motion_x(),
    y: raw.motion_y(),
    xrel: raw.motion_xrel(),
    yrel: raw.motion_yrel(),
  }
}

///|
fn MouseButtonEvent::from_raw(raw : @sys.Event) -> MouseButtonEvent {
  {
    window_id: raw.button_window_id(),
    mouse_id: raw.button_mouse_id(),
    button: raw.button_button(),
    clicks: raw.button_clicks(),
    x: raw.button_x(),
    y: raw.button_y(),
  }
}

///|
fn WindowEvent::from_raw(
  raw : @sys.Event,
  name : WindowEventName,
) -> WindowEvent {
  let size = match name {
    Resized | PixelSizeChanged =>
      Some(Size::{ width: raw.window_data1(), height: raw.window_data2() })
    Exposed | CloseRequested => None
  }
  { window_id: raw.window_window_id(), name, size }
}

///|
fn TextInputEvent::from_raw(raw : @sys.Event) -> TextInputEvent {
  { text: @utf8.decode_lossy(raw.text_text()) }
}

///|
fn WindowEventName::matches(
  self : Self,
  event : Event,
  window_id : UInt,
) -> WindowEvent? {
  let window_event = match event {
    WindowExposed(event) if self == Exposed => Some(event)
    WindowResized(event) if self == Resized => Some(event)
    WindowPixelSizeChanged(event) if self == PixelSizeChanged => Some(event)
    WindowCloseRequested(event) if self == CloseRequested => Some(event)
    _ => None
  }
  match window_event {
    Some(event) if event.window_id == window_id => Some(event)
    _ => None
  }
}

///|
pub fn EventListener::dispose(self : Self) -> Unit {
  @sys.remove_event_watch(self.raw)
}

///|
pub fn add_event_watch(
  callback : (Event) -> Unit,
) -> EventListener raise SdlError {
  let raw_callback = fn(raw_event) {
    callback(Event::from_raw(@sys.Event::from_bytes(raw_event)))
  }
  let raw = @sys.add_event_watch(call_event_watch_callback, raw_callback)
  if raw.is_null() {
    raise_last_error("SDL_AddEventWatch")
  }
  { raw, }
}

///|
pub fn Window::on(
  self : Self,
  name : WindowEventName,
  callback : (WindowEvent) -> Unit,
) -> EventListener raise SdlError {
  let window_id = self.id()
  add_event_watch(fn(event) {
    if name.matches(event, window_id) is Some(window_event) {
      callback(window_event)
    }
  })
}

///|
pub fn delay(milliseconds : UInt) -> Unit {
  @sys.delay(milliseconds)
}
