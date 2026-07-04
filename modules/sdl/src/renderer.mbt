///|
struct Renderer {
  raw : @sys.Renderer
}

///|
pub(all) struct Color {
  r : Byte
  g : Byte
  b : Byte
  a : Byte
} derive(Debug, Eq)

///|
pub fn Color::rgb(r~ : Byte, g~ : Byte, b~ : Byte) -> Color {
  { r, g, b, a: 255 }
}

///|
pub fn Color::rgba(r~ : Byte, g~ : Byte, b~ : Byte, a~ : Byte) -> Color {
  { r, g, b, a }
}

///|
pub(all) struct FRect {
  x : Float
  y : Float
  w : Float
  h : Float
} derive(Debug)

///|
pub fn FRect::FRect(x~ : Float, y~ : Float, w~ : Float, h~ : Float) -> FRect {
  { x, y, w, h }
}

///|
fn FRect::to_sys(self : Self) -> @sys.FRect {
  FRect(self.x, self.y, self.w, self.h)
}

///|
pub(all) struct Rect {
  x : Int
  y : Int
  w : Int
  h : Int
} derive(Debug, Eq)

///|
pub fn Rect::Rect(x~ : Int, y~ : Int, w~ : Int, h~ : Int) -> Rect {
  { x, y, w, h }
}

///|
fn Rect::to_sys(self : Self) -> @sys.Rect {
  Rect(self.x, self.y, self.w, self.h)
}

///|
pub fn Renderer::Renderer(
  window : Window,
  name? : String = "",
) -> Renderer raise SdlError {
  let raw = @sys.create_renderer(window.raw(), @utf8.encode(name))
  if raw.is_null() {
    raise_last_error("SDL_CreateRenderer")
  }
  { raw, }
}

///|
pub fn Renderer::destroy(self : Self) -> Unit {
  @sys.destroy_renderer(self.raw)
}

///|
pub fn Renderer::set_draw_color(
  self : Self,
  color : Color,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_render_draw_color(self.raw, color.r, color.g, color.b, color.a),
    "SDL_SetRenderDrawColor",
  )
}

///|
pub fn Renderer::clear(self : Self) -> Unit raise SdlError {
  check_ok(@sys.render_clear(self.raw), "SDL_RenderClear")
}

///|
pub fn Renderer::output_size(self : Self) -> Size raise SdlError {
  let width = Ref(0)
  let height = Ref(0)
  check_ok(
    @sys.get_current_render_output_size(self.raw, width, height),
    "SDL_GetCurrentRenderOutputSize",
  )
  { width: width.val, height: height.val }
}

///|
pub fn Renderer::present(self : Self) -> Unit raise SdlError {
  check_ok(@sys.render_present(self.raw), "SDL_RenderPresent")
}

///|
pub fn Renderer::fill_rect(
  self : Self,
  x~ : Float,
  y~ : Float,
  w~ : Float,
  h~ : Float,
) -> Unit raise SdlError {
  self.fill_frect(FRect(x~, y~, w~, h~))
}

///|
pub fn Renderer::fill_frect(self : Self, rect : FRect) -> Unit raise SdlError {
  check_ok(@sys.render_fill_rect(self.raw, rect.to_sys()), "SDL_RenderFillRect")
}

///|
pub fn Renderer::raw(self : Self) -> @sys.Renderer {
  self.raw
}
