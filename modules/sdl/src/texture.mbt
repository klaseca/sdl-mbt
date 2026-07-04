///|
struct Texture {
  raw : @sys.Texture
  _renderer : Renderer
}

///|
pub(all) struct FSize {
  width : Float
  height : Float
} derive(Debug, Eq)

///|
pub(all) enum PixelFormat {
  Rgba8888
  Abgr8888
  Bgra8888
  Bgra32
} derive(Debug, Eq)

///|
fn PixelFormat::to_sys(self : Self) -> UInt {
  match self {
    Rgba8888 => @sys.PIXELFORMAT_RGBA8888
    Abgr8888 => @sys.PIXELFORMAT_ABGR8888
    Bgra8888 => @sys.PIXELFORMAT_BGRA8888
    // SDL_PIXELFORMAT_BGRA32 is SDL_PIXELFORMAT_ARGB8888 on little-endian.
    Bgra32 => @sys.PIXELFORMAT_ARGB8888
  }
}

///|
pub(all) enum TextureAccess {
  Static
  Streaming
  Target
} derive(Debug, Eq)

///|
fn TextureAccess::to_sys(self : Self) -> UInt {
  match self {
    Static => @sys.TEXTUREACCESS_STATIC
    Streaming => @sys.TEXTUREACCESS_STREAMING
    Target => @sys.TEXTUREACCESS_TARGET
  }
}

///|
pub(all) enum BlendMode {
  NoBlend
  Blend
  BlendPremultiplied
  Add
  AddPremultiplied
  Mod
  Mul
} derive(Debug, Eq)

///|
fn BlendMode::to_sys(self : Self) -> UInt {
  match self {
    NoBlend => @sys.BLENDMODE_NONE
    Blend => @sys.BLENDMODE_BLEND
    BlendPremultiplied => @sys.BLENDMODE_BLEND_PREMULTIPLIED
    Add => @sys.BLENDMODE_ADD
    AddPremultiplied => @sys.BLENDMODE_ADD_PREMULTIPLIED
    Mod => @sys.BLENDMODE_MOD
    Mul => @sys.BLENDMODE_MUL
  }
}

///|
pub fn Texture::Texture(
  renderer : Renderer,
  width~ : Int,
  height~ : Int,
  format? : PixelFormat = Rgba8888,
  access? : TextureAccess = Static,
) -> Texture raise SdlError {
  let raw = @sys.create_texture(
    renderer.raw(),
    format.to_sys(),
    access.to_sys(),
    width,
    height,
  )
  if raw.is_null() {
    raise_last_error("SDL_CreateTexture")
  }
  { raw, _renderer: renderer }
}

///|
pub fn Renderer::create_texture(
  self : Self,
  width~ : Int,
  height~ : Int,
  format? : PixelFormat = Rgba8888,
  access? : TextureAccess = Static,
) -> Texture raise SdlError {
  Texture(self, width~, height~, format~, access~)
}

///|
pub fn Texture::destroy(self : Self) -> Unit {
  @sys.destroy_texture(self.raw)
}

///|
pub fn Texture::update(
  self : Self,
  pixels~ : Bytes,
  pitch~ : Int,
  rect? : Rect,
) -> Unit raise SdlError {
  let sys_rect = match rect {
    Some(value) => value.to_sys()
    None => Rect(0, 0, 0, 0)
  }
  let has_rect = match rect {
    Some(_) => true
    None => false
  }
  check_ok(
    @sys.update_texture(self.raw, sys_rect, has_rect, pixels, pitch),
    "SDL_UpdateTexture",
  )
}

///|
pub fn Texture::size(self : Self) -> FSize raise SdlError {
  let width : Ref[Float] = { val: 0.0 }
  let height : Ref[Float] = { val: 0.0 }
  check_ok(@sys.get_texture_size(self.raw, width, height), "SDL_GetTextureSize")
  { width: width.val, height: height.val }
}

///|
pub fn Texture::set_color_mod(
  self : Self,
  color : Color,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_texture_color_mod(self.raw, color.r, color.g, color.b),
    "SDL_SetTextureColorMod",
  )
}

///|
pub fn Texture::set_alpha_mod(self : Self, alpha : Byte) -> Unit raise SdlError {
  check_ok(
    @sys.set_texture_alpha_mod(self.raw, alpha),
    "SDL_SetTextureAlphaMod",
  )
}

///|
pub fn Texture::set_blend_mode(
  self : Self,
  blend_mode : BlendMode,
) -> Unit raise SdlError {
  check_ok(
    @sys.set_texture_blend_mode(self.raw, blend_mode.to_sys()),
    "SDL_SetTextureBlendMode",
  )
}

///|
pub fn Texture::raw(self : Self) -> @sys.Texture {
  self.raw
}

///|
fn Texture::rect(self : Self) -> FRect raise SdlError {
  let size = self.size()
  FRect(x=0.0, y=0.0, w=size.width, h=size.height)
}

///|
pub fn Renderer::render_texture(
  self : Self,
  texture : Texture,
  src? : FRect,
  dst? : FRect,
) -> Unit raise SdlError {
  let src_rect = match src {
    Some(rect) => rect
    None => texture.rect()
  }
  let dst_rect = match dst {
    Some(rect) => rect
    None => texture.rect()
  }
  check_ok(
    @sys.render_texture(
      self.raw,
      texture.raw(),
      src_rect.to_sys(),
      dst_rect.to_sys(),
    ),
    "SDL_RenderTexture",
  )
}
