// Generated file. Do not edit by hand.

///|
pub type Renderer

///|
#borrow(resource)
extern "c" fn renderer_is_null(resource : Renderer) -> Bool = "moonbit_sdl_renderer_is_null"

///|
pub fn Renderer::is_null(self : Self) -> Bool {
  renderer_is_null(self)
}

///|
pub type Texture

///|
#borrow(resource)
extern "c" fn texture_is_null(resource : Texture) -> Bool = "moonbit_sdl_texture_is_null"

///|
pub fn Texture::is_null(self : Self) -> Bool {
  texture_is_null(self)
}

///|
#external
pub type GPURenderState

///|
pub fn GPURenderState::to_pointer(self : Self) -> Pointer = "%identity"

///|
pub fn GPURenderState::is_null(self : Self) -> Bool {
  self.to_pointer().is_null()
}

///|
pub const PROP_RENDERER_CREATE_NAME_STRING : Bytes = b"SDL.renderer.create.name"

///|
pub const PROP_RENDERER_CREATE_WINDOW_POINTER : Bytes = b"SDL.renderer.create.window"

///|
pub const PROP_RENDERER_CREATE_SURFACE_POINTER : Bytes = b"SDL.renderer.create.surface"

///|
pub const PROP_RENDERER_CREATE_OUTPUT_COLORSPACE_NUMBER : Bytes = b"SDL.renderer.create.output_colorspace"

///|
pub const PROP_RENDERER_CREATE_PRESENT_VSYNC_NUMBER : Bytes = b"SDL.renderer.create.present_vsync"

///|
pub const PROP_RENDERER_CREATE_GPU_DEVICE_POINTER : Bytes = b"SDL.renderer.create.gpu.device"

///|
pub const PROP_RENDERER_CREATE_GPU_SHADERS_SPIRV_BOOLEAN : Bytes = b"SDL.renderer.create.gpu.shaders_spirv"

///|
pub const PROP_RENDERER_CREATE_GPU_SHADERS_DXIL_BOOLEAN : Bytes = b"SDL.renderer.create.gpu.shaders_dxil"

///|
pub const PROP_RENDERER_CREATE_GPU_SHADERS_MSL_BOOLEAN : Bytes = b"SDL.renderer.create.gpu.shaders_msl"

///|
pub const PROP_RENDERER_CREATE_VULKAN_INSTANCE_POINTER : Bytes = b"SDL.renderer.create.vulkan.instance"

///|
pub const PROP_RENDERER_CREATE_VULKAN_SURFACE_NUMBER : Bytes = b"SDL.renderer.create.vulkan.surface"

///|
pub const PROP_RENDERER_CREATE_VULKAN_PHYSICAL_DEVICE_POINTER : Bytes = b"SDL.renderer.create.vulkan.physical_device"

///|
pub const PROP_RENDERER_CREATE_VULKAN_DEVICE_POINTER : Bytes = b"SDL.renderer.create.vulkan.device"

///|
pub const PROP_RENDERER_CREATE_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER : Bytes = b"SDL.renderer.create.vulkan.graphics_queue_family_index"

///|
pub const PROP_RENDERER_CREATE_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER : Bytes = b"SDL.renderer.create.vulkan.present_queue_family_index"

///|
pub const PROP_RENDERER_NAME_STRING : Bytes = b"SDL.renderer.name"

///|
pub const PROP_RENDERER_WINDOW_POINTER : Bytes = b"SDL.renderer.window"

///|
pub const PROP_RENDERER_SURFACE_POINTER : Bytes = b"SDL.renderer.surface"

///|
pub const PROP_RENDERER_VSYNC_NUMBER : Bytes = b"SDL.renderer.vsync"

///|
pub const PROP_RENDERER_MAX_TEXTURE_SIZE_NUMBER : Bytes = b"SDL.renderer.max_texture_size"

///|
pub const PROP_RENDERER_TEXTURE_FORMATS_POINTER : Bytes = b"SDL.renderer.texture_formats"

///|
pub const PROP_RENDERER_TEXTURE_WRAPPING_BOOLEAN : Bytes = b"SDL.renderer.texture_wrapping"

///|
pub const PROP_RENDERER_OUTPUT_COLORSPACE_NUMBER : Bytes = b"SDL.renderer.output_colorspace"

///|
pub const PROP_RENDERER_HDR_ENABLED_BOOLEAN : Bytes = b"SDL.renderer.HDR_enabled"

///|
pub const PROP_RENDERER_SDR_WHITE_POINT_FLOAT : Bytes = b"SDL.renderer.SDR_white_point"

///|
pub const PROP_RENDERER_HDR_HEADROOM_FLOAT : Bytes = b"SDL.renderer.HDR_headroom"

///|
pub const PROP_RENDERER_D3D9_DEVICE_POINTER : Bytes = b"SDL.renderer.d3d9.device"

///|
pub const PROP_RENDERER_D3D11_DEVICE_POINTER : Bytes = b"SDL.renderer.d3d11.device"

///|
pub const PROP_RENDERER_D3D11_SWAPCHAIN_POINTER : Bytes = b"SDL.renderer.d3d11.swap_chain"

///|
pub const PROP_RENDERER_D3D12_DEVICE_POINTER : Bytes = b"SDL.renderer.d3d12.device"

///|
pub const PROP_RENDERER_D3D12_SWAPCHAIN_POINTER : Bytes = b"SDL.renderer.d3d12.swap_chain"

///|
pub const PROP_RENDERER_D3D12_COMMAND_QUEUE_POINTER : Bytes = b"SDL.renderer.d3d12.command_queue"

///|
pub const PROP_RENDERER_VULKAN_INSTANCE_POINTER : Bytes = b"SDL.renderer.vulkan.instance"

///|
pub const PROP_RENDERER_VULKAN_SURFACE_NUMBER : Bytes = b"SDL.renderer.vulkan.surface"

///|
pub const PROP_RENDERER_VULKAN_PHYSICAL_DEVICE_POINTER : Bytes = b"SDL.renderer.vulkan.physical_device"

///|
pub const PROP_RENDERER_VULKAN_DEVICE_POINTER : Bytes = b"SDL.renderer.vulkan.device"

///|
pub const PROP_RENDERER_VULKAN_GRAPHICS_QUEUE_FAMILY_INDEX_NUMBER : Bytes = b"SDL.renderer.vulkan.graphics_queue_family_index"

///|
pub const PROP_RENDERER_VULKAN_PRESENT_QUEUE_FAMILY_INDEX_NUMBER : Bytes = b"SDL.renderer.vulkan.present_queue_family_index"

///|
pub const PROP_RENDERER_VULKAN_SWAPCHAIN_IMAGE_COUNT_NUMBER : Bytes = b"SDL.renderer.vulkan.swapchain_image_count"

///|
pub const PROP_RENDERER_GPU_DEVICE_POINTER : Bytes = b"SDL.renderer.gpu.device"

///|
pub const PROP_TEXTURE_CREATE_COLORSPACE_NUMBER : Bytes = b"SDL.texture.create.colorspace"

///|
pub const PROP_TEXTURE_CREATE_FORMAT_NUMBER : Bytes = b"SDL.texture.create.format"

///|
pub const PROP_TEXTURE_CREATE_ACCESS_NUMBER : Bytes = b"SDL.texture.create.access"

///|
pub const PROP_TEXTURE_CREATE_WIDTH_NUMBER : Bytes = b"SDL.texture.create.width"

///|
pub const PROP_TEXTURE_CREATE_HEIGHT_NUMBER : Bytes = b"SDL.texture.create.height"

///|
pub const PROP_TEXTURE_CREATE_PALETTE_POINTER : Bytes = b"SDL.texture.create.palette"

///|
pub const PROP_TEXTURE_CREATE_SDR_WHITE_POINT_FLOAT : Bytes = b"SDL.texture.create.SDR_white_point"

///|
pub const PROP_TEXTURE_CREATE_HDR_HEADROOM_FLOAT : Bytes = b"SDL.texture.create.HDR_headroom"

///|
pub const PROP_TEXTURE_CREATE_D3D11_TEXTURE_POINTER : Bytes = b"SDL.texture.create.d3d11.texture"

///|
pub const PROP_TEXTURE_CREATE_D3D11_TEXTURE_U_POINTER : Bytes = b"SDL.texture.create.d3d11.texture_u"

///|
pub const PROP_TEXTURE_CREATE_D3D11_TEXTURE_V_POINTER : Bytes = b"SDL.texture.create.d3d11.texture_v"

///|
pub const PROP_TEXTURE_CREATE_D3D12_TEXTURE_POINTER : Bytes = b"SDL.texture.create.d3d12.texture"

///|
pub const PROP_TEXTURE_CREATE_D3D12_TEXTURE_U_POINTER : Bytes = b"SDL.texture.create.d3d12.texture_u"

///|
pub const PROP_TEXTURE_CREATE_D3D12_TEXTURE_V_POINTER : Bytes = b"SDL.texture.create.d3d12.texture_v"

///|
pub const PROP_TEXTURE_CREATE_METAL_PIXELBUFFER_POINTER : Bytes = b"SDL.texture.create.metal.pixelbuffer"

///|
pub const PROP_TEXTURE_CREATE_OPENGL_TEXTURE_NUMBER : Bytes = b"SDL.texture.create.opengl.texture"

///|
pub const PROP_TEXTURE_CREATE_OPENGL_TEXTURE_UV_NUMBER : Bytes = b"SDL.texture.create.opengl.texture_uv"

///|
pub const PROP_TEXTURE_CREATE_OPENGL_TEXTURE_U_NUMBER : Bytes = b"SDL.texture.create.opengl.texture_u"

///|
pub const PROP_TEXTURE_CREATE_OPENGL_TEXTURE_V_NUMBER : Bytes = b"SDL.texture.create.opengl.texture_v"

///|
pub const PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_NUMBER : Bytes = b"SDL.texture.create.opengles2.texture"

///|
pub const PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_UV_NUMBER : Bytes = b"SDL.texture.create.opengles2.texture_uv"

///|
pub const PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_U_NUMBER : Bytes = b"SDL.texture.create.opengles2.texture_u"

///|
pub const PROP_TEXTURE_CREATE_OPENGLES2_TEXTURE_V_NUMBER : Bytes = b"SDL.texture.create.opengles2.texture_v"

///|
pub const PROP_TEXTURE_CREATE_VULKAN_TEXTURE_NUMBER : Bytes = b"SDL.texture.create.vulkan.texture"

///|
pub const PROP_TEXTURE_CREATE_VULKAN_LAYOUT_NUMBER : Bytes = b"SDL.texture.create.vulkan.layout"

///|
pub const PROP_TEXTURE_CREATE_GPU_TEXTURE_POINTER : Bytes = b"SDL.texture.create.gpu.texture"

///|
pub const PROP_TEXTURE_CREATE_GPU_TEXTURE_UV_POINTER : Bytes = b"SDL.texture.create.gpu.texture_uv"

///|
pub const PROP_TEXTURE_CREATE_GPU_TEXTURE_U_POINTER : Bytes = b"SDL.texture.create.gpu.texture_u"

///|
pub const PROP_TEXTURE_CREATE_GPU_TEXTURE_V_POINTER : Bytes = b"SDL.texture.create.gpu.texture_v"

///|
pub const PROP_TEXTURE_COLORSPACE_NUMBER : Bytes = b"SDL.texture.colorspace"

///|
pub const PROP_TEXTURE_FORMAT_NUMBER : Bytes = b"SDL.texture.format"

///|
pub const PROP_TEXTURE_ACCESS_NUMBER : Bytes = b"SDL.texture.access"

///|
pub const PROP_TEXTURE_WIDTH_NUMBER : Bytes = b"SDL.texture.width"

///|
pub const PROP_TEXTURE_HEIGHT_NUMBER : Bytes = b"SDL.texture.height"

///|
pub const PROP_TEXTURE_SDR_WHITE_POINT_FLOAT : Bytes = b"SDL.texture.SDR_white_point"

///|
pub const PROP_TEXTURE_HDR_HEADROOM_FLOAT : Bytes = b"SDL.texture.HDR_headroom"

///|
pub const PROP_TEXTURE_D3D11_TEXTURE_POINTER : Bytes = b"SDL.texture.d3d11.texture"

///|
pub const PROP_TEXTURE_D3D11_TEXTURE_U_POINTER : Bytes = b"SDL.texture.d3d11.texture_u"

///|
pub const PROP_TEXTURE_D3D11_TEXTURE_V_POINTER : Bytes = b"SDL.texture.d3d11.texture_v"

///|
pub const PROP_TEXTURE_D3D12_TEXTURE_POINTER : Bytes = b"SDL.texture.d3d12.texture"

///|
pub const PROP_TEXTURE_D3D12_TEXTURE_U_POINTER : Bytes = b"SDL.texture.d3d12.texture_u"

///|
pub const PROP_TEXTURE_D3D12_TEXTURE_V_POINTER : Bytes = b"SDL.texture.d3d12.texture_v"

///|
pub const PROP_TEXTURE_OPENGL_TEXTURE_NUMBER : Bytes = b"SDL.texture.opengl.texture"

///|
pub const PROP_TEXTURE_OPENGL_TEXTURE_UV_NUMBER : Bytes = b"SDL.texture.opengl.texture_uv"

///|
pub const PROP_TEXTURE_OPENGL_TEXTURE_U_NUMBER : Bytes = b"SDL.texture.opengl.texture_u"

///|
pub const PROP_TEXTURE_OPENGL_TEXTURE_V_NUMBER : Bytes = b"SDL.texture.opengl.texture_v"

///|
pub const PROP_TEXTURE_OPENGL_TEXTURE_TARGET_NUMBER : Bytes = b"SDL.texture.opengl.target"

///|
pub const PROP_TEXTURE_OPENGL_TEX_W_FLOAT : Bytes = b"SDL.texture.opengl.tex_w"

///|
pub const PROP_TEXTURE_OPENGL_TEX_H_FLOAT : Bytes = b"SDL.texture.opengl.tex_h"

///|
pub const PROP_TEXTURE_OPENGLES2_TEXTURE_NUMBER : Bytes = b"SDL.texture.opengles2.texture"

///|
pub const PROP_TEXTURE_OPENGLES2_TEXTURE_UV_NUMBER : Bytes = b"SDL.texture.opengles2.texture_uv"

///|
pub const PROP_TEXTURE_OPENGLES2_TEXTURE_U_NUMBER : Bytes = b"SDL.texture.opengles2.texture_u"

///|
pub const PROP_TEXTURE_OPENGLES2_TEXTURE_V_NUMBER : Bytes = b"SDL.texture.opengles2.texture_v"

///|
pub const PROP_TEXTURE_OPENGLES2_TEXTURE_TARGET_NUMBER : Bytes = b"SDL.texture.opengles2.target"

///|
pub const PROP_TEXTURE_VULKAN_TEXTURE_NUMBER : Bytes = b"SDL.texture.vulkan.texture"

///|
pub const PROP_TEXTURE_GPU_TEXTURE_POINTER : Bytes = b"SDL.texture.gpu.texture"

///|
pub const PROP_TEXTURE_GPU_TEXTURE_UV_POINTER : Bytes = b"SDL.texture.gpu.texture_uv"

///|
pub const PROP_TEXTURE_GPU_TEXTURE_U_POINTER : Bytes = b"SDL.texture.gpu.texture_u"

///|
pub const PROP_TEXTURE_GPU_TEXTURE_V_POINTER : Bytes = b"SDL.texture.gpu.texture_v"

///|
pub const TEXTUREACCESS_STATIC : UInt = 0

///|
pub const TEXTUREACCESS_STREAMING : UInt = 1

///|
pub const TEXTUREACCESS_TARGET : UInt = 2

///|
#borrow(window, name)
pub extern "c" fn create_renderer(window : Window, name : Bytes) -> Renderer = "moonbit_sdl_create_renderer"

///|
#borrow(renderer, w, h)
pub extern "c" fn get_current_render_output_size(renderer : Renderer, w : Ref[Int], h : Ref[Int]) -> Bool = "moonbit_sdl_get_current_render_output_size"

///|
#borrow(renderer)
pub extern "c" fn create_texture(renderer : Renderer, format : UInt, access : UInt, w : Int, h : Int) -> Texture = "moonbit_sdl_create_texture"

///|
#borrow(texture, w, h)
pub extern "c" fn get_texture_size(texture : Texture, w : Ref[Float], h : Ref[Float]) -> Bool = "moonbit_sdl_get_texture_size"

///|
#borrow(texture)
pub extern "c" fn set_texture_color_mod(texture : Texture, r : Byte, g : Byte, b : Byte) -> Bool = "moonbit_sdl_set_texture_color_mod"

///|
#borrow(texture)
pub extern "c" fn set_texture_alpha_mod(texture : Texture, alpha : Byte) -> Bool = "moonbit_sdl_set_texture_alpha_mod"

///|
#borrow(texture)
pub extern "c" fn set_texture_blend_mode(texture : Texture, blendMode : UInt) -> Bool = "moonbit_sdl_set_texture_blend_mode"

///|
#borrow(texture, rect, pixels)
extern "c" fn update_texture_ffi(texture : Texture, rect : Bytes, has_rect : Bool, pixels : Bytes, pitch : Int) -> Bool = "moonbit_sdl_update_texture_ffi"

///|
pub fn update_texture(texture : Texture, rect : Rect, has_rect : Bool, pixels : Bytes, pitch : Int) -> Bool {
  update_texture_ffi(texture, rect.to_bytes(), has_rect, pixels, pitch)
}

///|
#borrow(texture, rect, pixels, pitch)
extern "c" fn lock_texture_ffi(texture : Texture, rect : Bytes, has_rect : Bool, pixels : Ref[Pointer], pitch : Ref[Int]) -> Bool = "moonbit_sdl_lock_texture_ffi"

///|
pub fn lock_texture(texture : Texture, rect : Rect, has_rect : Bool, pixels : Ref[Pointer], pitch : Ref[Int]) -> Bool {
  lock_texture_ffi(texture, rect.to_bytes(), has_rect, pixels, pitch)
}

///|
#borrow(texture)
pub extern "c" fn unlock_texture(texture : Texture) = "moonbit_sdl_unlock_texture"

///|
#borrow(renderer)
pub extern "c" fn set_render_draw_color(renderer : Renderer, r : Byte, g : Byte, b : Byte, a : Byte) -> Bool = "moonbit_sdl_set_render_draw_color"

///|
#borrow(renderer)
pub extern "c" fn render_clear(renderer : Renderer) -> Bool = "moonbit_sdl_render_clear"

///|
#borrow(renderer, rect)
extern "c" fn render_fill_rect_ffi(renderer : Renderer, rect : Bytes) -> Bool = "moonbit_sdl_render_fill_rect_ffi"

///|
pub fn render_fill_rect(renderer : Renderer, rect : FRect) -> Bool {
  render_fill_rect_ffi(renderer, rect.to_bytes())
}

///|
#borrow(renderer, texture, srcrect, dstrect)
extern "c" fn render_texture_ffi(renderer : Renderer, texture : Texture, srcrect : Bytes, dstrect : Bytes) -> Bool = "moonbit_sdl_render_texture_ffi"

///|
pub fn render_texture(renderer : Renderer, texture : Texture, srcrect : FRect, dstrect : FRect) -> Bool {
  render_texture_ffi(renderer, texture, srcrect.to_bytes(), dstrect.to_bytes())
}

///|
#borrow(renderer)
pub extern "c" fn render_present(renderer : Renderer) -> Bool = "moonbit_sdl_render_present"

///|
#borrow(texture)
pub extern "c" fn destroy_texture(texture : Texture) = "moonbit_sdl_destroy_texture"

///|
#borrow(renderer)
pub extern "c" fn destroy_renderer(renderer : Renderer) = "moonbit_sdl_destroy_renderer"
