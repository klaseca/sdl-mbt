///|
const PROP_WINDOW_CLOSE_BEHAVIOR : Bytes = b"moonbit.sdl.window.close_behavior"

///|
pub(all) enum WindowCloseBehavior {
  ExitApp
  Hide
  Ignore
} derive(Debug, Eq)

///|
fn WindowCloseBehavior::to_int64(self : Self) -> Int64 {
  match self {
    ExitApp => 0
    Hide => 1
    Ignore => 2
  }
}

///|
fn WindowCloseBehavior::from_int64(value : Int64) -> Self {
  match value {
    1 => Hide
    2 => Ignore
    _ => ExitApp
  }
}

///|
fn window_close_behavior(window_id : UInt) -> WindowCloseBehavior {
  let window = @sys.get_window_from_id(window_id)
  if window.is_null() {
    ExitApp
  } else {
    let props = @sys.get_window_properties(window)
    if props == 0 {
      ExitApp
    } else {
      WindowCloseBehavior::from_int64(
        @sys.get_number_property(
          props,
          PROP_WINDOW_CLOSE_BEHAVIOR,
          ExitApp.to_int64(),
        ),
      )
    }
  }
}

///|
fn set_window_close_behavior(
  window_id : UInt,
  behavior : WindowCloseBehavior,
) -> Bool {
  let window = @sys.get_window_from_id(window_id)
  if window.is_null() {
    false
  } else {
    set_window_close_behavior_raw(window, behavior)
  }
}

///|
fn set_window_close_behavior_raw(
  window : @sys.Window,
  behavior : WindowCloseBehavior,
) -> Bool {
  let props = @sys.get_window_properties(window)
  props != 0 &&
  @sys.set_number_property(
    props,
    PROP_WINDOW_CLOSE_BEHAVIOR,
    behavior.to_int64(),
  )
}

///|
fn hide_window_by_id(window_id : UInt) -> Bool {
  let window = @sys.get_window_from_id(window_id)
  !window.is_null() && @sys.hide_window(window)
}

///|
pub(all) struct Size {
  width : Int
  height : Int
} derive(Debug, Eq)

///|
pub(all) struct Position {
  x : Int
  y : Int
} derive(Debug, Eq)

///|
pub(all) enum WindowPlacement {
  Positioned(Position)
  Centered
  CenteredOnDisplay(UInt)
  Undefined
  UndefinedOnDisplay(UInt)
} derive(Debug, Eq)

///|
const WINDOWPOS_UNDEFINED_MASK : UInt = 0x1FFF0000

///|
const WINDOWPOS_CENTERED_MASK : UInt = 0x2FFF0000

///|
fn sdl_windowpos(mask : UInt, display_id : UInt) -> Int {
  mask.lor(display_id).reinterpret_as_int()
}

///|
fn WindowPlacement::to_position(self : Self) -> Position {
  match self {
    Positioned(position) => position
    Centered => {
      let position = sdl_windowpos(WINDOWPOS_CENTERED_MASK, 0)
      { x: position, y: position }
    }
    CenteredOnDisplay(display_id) => {
      let position = sdl_windowpos(WINDOWPOS_CENTERED_MASK, display_id)
      { x: position, y: position }
    }
    Undefined => {
      let position = sdl_windowpos(WINDOWPOS_UNDEFINED_MASK, 0)
      { x: position, y: position }
    }
    UndefinedOnDisplay(display_id) => {
      let position = sdl_windowpos(WINDOWPOS_UNDEFINED_MASK, display_id)
      { x: position, y: position }
    }
  }
}

///|
struct Window {
  raw : @sys.Window
}

///|
pub fn Window::Window(
  title~ : String,
  width~ : Int,
  height~ : Int,
  placement? : WindowPlacement,
  hidden? : Bool,
  resizable? : Bool,
  borderless? : Bool,
  always_on_top? : Bool,
  high_pixel_density? : Bool,
  constrain_popup? : Bool,
  external_graphics_context? : Bool,
  fullscreen? : Bool,
  maximized? : Bool,
  minimized? : Bool,
  menu? : Bool,
  modal? : Bool,
  mouse_grabbed? : Bool,
  focusable? : Bool,
  opengl? : Bool,
  metal? : Bool,
  vulkan? : Bool,
  transparent? : Bool,
  tooltip? : Bool,
  utility? : Bool,
  custom_properties? : Array[Property],
  close_behavior? : WindowCloseBehavior = ExitApp,
) -> Window raise SdlError {
  let properties = Properties()
  defer properties.destroy()

  properties.set_string(
    name=@sys.PROP_WINDOW_CREATE_TITLE_STRING,
    value=Some(title),
  )
  properties.set_number(
    name=@sys.PROP_WINDOW_CREATE_WIDTH_NUMBER,
    value=Some(Int64::from_int(width)),
  )
  properties.set_number(
    name=@sys.PROP_WINDOW_CREATE_HEIGHT_NUMBER,
    value=Some(Int64::from_int(height)),
  )
  if placement is Some(placement) {
    let position = placement.to_position()

    properties.set_number(
      name=@sys.PROP_WINDOW_CREATE_X_NUMBER,
      value=Some(Int64::from_int(position.x)),
    )
    properties.set_number(
      name=@sys.PROP_WINDOW_CREATE_Y_NUMBER,
      value=Some(Int64::from_int(position.y)),
    )
  }
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_HIDDEN_BOOLEAN,
    value=hidden,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_RESIZABLE_BOOLEAN,
    value=resizable,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_BORDERLESS_BOOLEAN,
    value=borderless,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_ALWAYS_ON_TOP_BOOLEAN,
    value=always_on_top,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_HIGH_PIXEL_DENSITY_BOOLEAN,
    value=high_pixel_density,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_CONSTRAIN_POPUP_BOOLEAN,
    value=constrain_popup,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_EXTERNAL_GRAPHICS_CONTEXT_BOOLEAN,
    value=external_graphics_context,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_FULLSCREEN_BOOLEAN,
    value=fullscreen,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_MAXIMIZED_BOOLEAN,
    value=maximized,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_MINIMIZED_BOOLEAN,
    value=minimized,
  )
  properties.set_boolean(name=@sys.PROP_WINDOW_CREATE_MENU_BOOLEAN, value=menu)
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_MODAL_BOOLEAN,
    value=modal,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_MOUSE_GRABBED_BOOLEAN,
    value=mouse_grabbed,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_FOCUSABLE_BOOLEAN,
    value=focusable,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_OPENGL_BOOLEAN,
    value=opengl,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_METAL_BOOLEAN,
    value=metal,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_VULKAN_BOOLEAN,
    value=vulkan,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_TRANSPARENT_BOOLEAN,
    value=transparent,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_TOOLTIP_BOOLEAN,
    value=tooltip,
  )
  properties.set_boolean(
    name=@sys.PROP_WINDOW_CREATE_UTILITY_BOOLEAN,
    value=utility,
  )
  if custom_properties is Some(custom_properties) {
    for property in custom_properties {
      properties.set_property(property)
    }
  }
  let raw = @sys.create_window_with_properties(properties.raw())
  if raw.is_null() {
    raise_last_error("SDL_CreateWindowWithProperties")
  }
  if !set_window_close_behavior_raw(raw, close_behavior) {
    @sys.destroy_window(raw)
    raise_last_error("SDL_SetNumberProperty")
  }
  { raw, }
}

///|
pub fn Window::destroy(self : Self) -> Unit {
  @sys.destroy_window(self.raw)
}

///|
pub fn Window::id(self : Self) -> UInt raise SdlError {
  let id = @sys.get_window_id(self.raw)
  if id == 0 {
    raise_last_error("SDL_GetWindowID")
  }
  id
}

///|
pub fn Window::set_close_behavior(
  self : Self,
  behavior : WindowCloseBehavior,
) -> Unit raise SdlError {
  check_ok(
    set_window_close_behavior(self.id(), behavior),
    "SDL_SetNumberProperty",
  )
}

///|
pub fn Window::flags(self : Self) -> UInt64 {
  @sys.get_window_flags(self.raw)
}

///|
pub fn Window::set_title(self : Self, title : String) -> Unit raise SdlError {
  check_ok(
    @sys.set_window_title(self.raw, @utf8.encode(title)),
    "SDL_SetWindowTitle",
  )
}

///|
pub fn Window::title(self : Self) -> String {
  @utf8.decode_lossy(@sys.get_window_title(self.raw))
}

///|
pub fn Window::set_position(
  self : Self,
  x~ : Int,
  y~ : Int,
) -> Unit raise SdlError {
  check_ok(@sys.set_window_position(self.raw, x, y), "SDL_SetWindowPosition")
}

///|
pub fn Window::set_placement(
  self : Self,
  placement : WindowPlacement,
) -> Unit raise SdlError {
  let position = placement.to_position()
  self.set_position(x=position.x, y=position.y)
}

///|
pub fn Window::position(self : Self) -> Position raise SdlError {
  let x : Ref[Int] = { val: 0 }
  let y : Ref[Int] = { val: 0 }
  check_ok(@sys.get_window_position(self.raw, x, y), "SDL_GetWindowPosition")
  { x: x.val, y: y.val }
}

///|
pub fn Window::set_size(
  self : Self,
  width~ : Int,
  height~ : Int,
) -> Unit raise SdlError {
  check_ok(@sys.set_window_size(self.raw, width, height), "SDL_SetWindowSize")
}

///|
pub fn Window::size(self : Self) -> Size raise SdlError {
  let width : Ref[Int] = { val: 0 }
  let height : Ref[Int] = { val: 0 }
  check_ok(@sys.get_window_size(self.raw, width, height), "SDL_GetWindowSize")
  { width: width.val, height: height.val }
}

///|
pub fn Window::size_in_pixels(self : Self) -> Size raise SdlError {
  let width : Ref[Int] = { val: 0 }
  let height : Ref[Int] = { val: 0 }
  check_ok(
    @sys.get_window_size_in_pixels(self.raw, width, height),
    "SDL_GetWindowSizeInPixels",
  )
  { width: width.val, height: height.val }
}

///|
pub fn Window::set_minimum_size(
  self : Self,
  width~ : Int,
  height~ : Int,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_window_minimum_size(self.raw, width, height),
    "SDL_SetWindowMinimumSize",
  )
}

///|
pub fn Window::minimum_size(self : Self) -> Size raise SdlError {
  let width : Ref[Int] = { val: 0 }
  let height : Ref[Int] = { val: 0 }
  check_ok(
    @sys.get_window_minimum_size(self.raw, width, height),
    "SDL_GetWindowMinimumSize",
  )
  { width: width.val, height: height.val }
}

///|
pub fn Window::set_maximum_size(
  self : Self,
  width~ : Int,
  height~ : Int,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_window_maximum_size(self.raw, width, height),
    "SDL_SetWindowMaximumSize",
  )
}

///|
pub fn Window::maximum_size(self : Self) -> Size raise SdlError {
  let width : Ref[Int] = { val: 0 }
  let height : Ref[Int] = { val: 0 }
  check_ok(
    @sys.get_window_maximum_size(self.raw, width, height),
    "SDL_GetWindowMaximumSize",
  )
  { width: width.val, height: height.val }
}

///|
pub fn Window::set_bordered(
  self : Self,
  bordered : Bool,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_window_bordered(self.raw, bordered),
    "SDL_SetWindowBordered",
  )
}

///|
pub fn Window::set_resizable(
  self : Self,
  resizable : Bool,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_window_resizable(self.raw, resizable),
    "SDL_SetWindowResizable",
  )
}

///|
pub fn Window::set_always_on_top(
  self : Self,
  on_top : Bool,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_window_always_on_top(self.raw, on_top),
    "SDL_SetWindowAlwaysOnTop",
  )
}

///|
pub fn Window::show(self : Self) -> Unit raise SdlError {
  check_ok(@sys.show_window(self.raw), "SDL_ShowWindow")
}

///|
pub fn Window::hide(self : Self) -> Unit raise SdlError {
  check_ok(@sys.hide_window(self.raw), "SDL_HideWindow")
}

///|
pub fn Window::raise_window(self : Self) -> Unit raise SdlError {
  check_ok(@sys.raise_window(self.raw), "SDL_RaiseWindow")
}

///|
pub fn Window::maximize(self : Self) -> Unit raise SdlError {
  check_ok(@sys.maximize_window(self.raw), "SDL_MaximizeWindow")
}

///|
pub fn Window::minimize(self : Self) -> Unit raise SdlError {
  check_ok(@sys.minimize_window(self.raw), "SDL_MinimizeWindow")
}

///|
pub fn Window::restore(self : Self) -> Unit raise SdlError {
  check_ok(@sys.restore_window(self.raw), "SDL_RestoreWindow")
}

///|
pub fn Window::set_fullscreen(
  self : Self,
  fullscreen : Bool,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_window_fullscreen(self.raw, fullscreen),
    "SDL_SetWindowFullscreen",
  )
}

///|
pub fn Window::set_keyboard_grab(
  self : Self,
  grabbed : Bool,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_window_keyboard_grab(self.raw, grabbed),
    "SDL_SetWindowKeyboardGrab",
  )
}

///|
pub fn Window::keyboard_grab(self : Self) -> Bool {
  @sys.get_window_keyboard_grab(self.raw)
}

///|
pub fn Window::set_mouse_grab(
  self : Self,
  grabbed : Bool,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_window_mouse_grab(self.raw, grabbed),
    "SDL_SetWindowMouseGrab",
  )
}

///|
pub fn Window::mouse_grab(self : Self) -> Bool {
  @sys.get_window_mouse_grab(self.raw)
}

///|
pub fn Window::set_opacity(self : Self, opacity : Float) -> Unit raise SdlError {
  check_ok(@sys.set_window_opacity(self.raw, opacity), "SDL_SetWindowOpacity")
}

///|
pub fn Window::opacity(self : Self) -> Float raise SdlError {
  let opacity = @sys.get_window_opacity(self.raw)
  if opacity < 0.0 {
    raise_last_error("SDL_GetWindowOpacity")
  }
  opacity
}

///|
pub fn Window::show_system_menu(
  self : Self,
  x~ : Int,
  y~ : Int,
) -> Unit raise SdlError {
  check_ok(
    @sys.show_window_system_menu(self.raw, x, y),
    "SDL_ShowWindowSystemMenu",
  )
}

///|
pub fn Window::start_text_input(self : Self) -> Unit raise SdlError {
  check_ok(@sys.start_text_input(self.raw), "SDL_StartTextInput")
}

///|
pub fn Window::stop_text_input(self : Self) -> Unit raise SdlError {
  check_ok(@sys.stop_text_input(self.raw), "SDL_StopTextInput")
}

///|
pub fn Window::raw(self : Self) -> @sys.Window {
  self.raw
}
