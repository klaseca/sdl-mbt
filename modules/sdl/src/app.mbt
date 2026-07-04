///|
pub(all) enum ControlFlow {
  Poll
  Wait(Int)
  Exit
} derive(Debug, Eq)

///|
struct App {
  init_flags : UInt
  mut control_flow : ControlFlow
}

///|
pub fn App::App(
  init_flags? : UInt = INIT_VIDEO,
  control_flow? : ControlFlow = Wait(16),
) -> App {
  { init_flags, control_flow }
}

///|
pub fn App::run(
  self : Self,
  setup : (App) -> Unit raise SdlError,
) -> Unit raise SdlError {
  init_lib(self.init_flags)
  defer quit()
  defer self.exit()
  setup(self)
}

///|
pub fn App::run_loop(
  self : Self,
  update : () -> Unit raise SdlError,
) -> Unit raise SdlError {
  for ;; {
    if !self.is_running() {
      break
    }
    self.drain_events()
    if !self.is_running() {
      break
    }
    update()
    if self.control_flow is Wait(ms) && wait_event_timeout(ms) is Some(event) {
      self.process_event(event)
    }
  }
}

///|
pub fn App::exit(self : Self) -> Unit {
  self.control_flow = Exit
}

///|
pub fn App::is_running(self : Self) -> Bool {
  match self.control_flow {
    Exit => false
    Poll | Wait(_) => true
  }
}

///|
fn App::process_event(self : Self, event : Event) -> Unit raise SdlError {
  match event {
    Quit => self.exit()
    WindowCloseRequested(event) =>
      match window_close_behavior(event.window_id) {
        ExitApp => self.exit()
        Hide => check_ok(hide_window_by_id(event.window_id), "SDL_HideWindow")
        Ignore => ()
      }
    _ => ()
  }
}

///|
fn App::drain_events(self : Self) -> Unit raise SdlError {
  for ;; {
    if !self.is_running() {
      break
    }
    match poll_event() {
      Some(event) => self.process_event(event)
      None => break
    }
  }
}
