///|
pub using @sys {
  INIT_AUDIO,
  INIT_VIDEO,
  INIT_JOYSTICK,
  INIT_HAPTIC,
  INIT_GAMEPAD,
  INIT_EVENTS,
  INIT_SENSOR,
  INIT_CAMERA,
}

///|
pub fn init_lib(flags : UInt) -> Unit raise SdlError {
  check_ok(@sys.init_lib(flags), "SDL_Init")
}

///|
pub fn quit() -> Unit {
  @sys.quit()
}
