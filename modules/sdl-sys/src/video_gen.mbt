// Generated file. Do not edit by hand.

///|
#external
pub type DisplayModeData

///|
pub fn DisplayModeData::to_pointer(self : Self) -> Pointer = "%identity"

///|
pub fn DisplayModeData::is_null(self : Self) -> Bool {
  self.to_pointer().is_null()
}

///|
pub type Window

///|
#borrow(resource)
extern "c" fn window_is_null(resource : Window) -> Bool = "moonbit_sdl_window_is_null"

///|
pub fn Window::is_null(self : Self) -> Bool {
  window_is_null(self)
}

///|
pub const PROP_DISPLAY_HDR_ENABLED_BOOLEAN : Bytes = b"SDL.display.HDR_enabled"

///|
pub const PROP_DISPLAY_KMSDRM_PANEL_ORIENTATION_NUMBER : Bytes = b"SDL.display.KMSDRM.panel_orientation"

///|
pub const PROP_DISPLAY_WAYLAND_WL_OUTPUT_POINTER : Bytes = b"SDL.display.wayland.wl_output"

///|
pub const PROP_DISPLAY_WINDOWS_HMONITOR_POINTER : Bytes = b"SDL.display.windows.hmonitor"

///|
pub const PROP_GLOBAL_VIDEO_WAYLAND_WL_DISPLAY_POINTER : Bytes = b"SDL.video.wayland.wl_display"

///|
pub const PROP_WINDOW_ANDROID_SURFACE_POINTER : Bytes = b"SDL.window.android.surface"

///|
pub const PROP_WINDOW_ANDROID_WINDOW_POINTER : Bytes = b"SDL.window.android.window"

///|
pub const PROP_WINDOW_COCOA_METAL_VIEW_TAG_NUMBER : Bytes = b"SDL.window.cocoa.metal_view_tag"

///|
pub const PROP_WINDOW_COCOA_WINDOW_POINTER : Bytes = b"SDL.window.cocoa.window"

///|
pub const PROP_WINDOW_CREATE_ALWAYS_ON_TOP_BOOLEAN : Bytes = b"SDL.window.create.always_on_top"

///|
pub const PROP_WINDOW_CREATE_BORDERLESS_BOOLEAN : Bytes = b"SDL.window.create.borderless"

///|
pub const PROP_WINDOW_CREATE_COCOA_VIEW_POINTER : Bytes = b"SDL.window.create.cocoa.view"

///|
pub const PROP_WINDOW_CREATE_COCOA_WINDOW_POINTER : Bytes = b"SDL.window.create.cocoa.window"

///|
pub const PROP_WINDOW_CREATE_CONSTRAIN_POPUP_BOOLEAN : Bytes = b"SDL.window.create.constrain_popup"

///|
pub const PROP_WINDOW_CREATE_EMSCRIPTEN_CANVAS_ID_STRING : Bytes = b"SDL.window.create.emscripten.canvas_id"

///|
pub const PROP_WINDOW_CREATE_EMSCRIPTEN_KEYBOARD_ELEMENT_STRING : Bytes = b"SDL.window.create.emscripten.keyboard_element"

///|
pub const PROP_WINDOW_CREATE_EXTERNAL_GRAPHICS_CONTEXT_BOOLEAN : Bytes = b"SDL.window.create.external_graphics_context"

///|
pub const PROP_WINDOW_CREATE_FLAGS_NUMBER : Bytes = b"SDL.window.create.flags"

///|
pub const PROP_WINDOW_CREATE_FOCUSABLE_BOOLEAN : Bytes = b"SDL.window.create.focusable"

///|
pub const PROP_WINDOW_CREATE_FULLSCREEN_BOOLEAN : Bytes = b"SDL.window.create.fullscreen"

///|
pub const PROP_WINDOW_CREATE_HEIGHT_NUMBER : Bytes = b"SDL.window.create.height"

///|
pub const PROP_WINDOW_CREATE_HIDDEN_BOOLEAN : Bytes = b"SDL.window.create.hidden"

///|
pub const PROP_WINDOW_CREATE_HIGH_PIXEL_DENSITY_BOOLEAN : Bytes = b"SDL.window.create.high_pixel_density"

///|
pub const PROP_WINDOW_CREATE_MAXIMIZED_BOOLEAN : Bytes = b"SDL.window.create.maximized"

///|
pub const PROP_WINDOW_CREATE_MENU_BOOLEAN : Bytes = b"SDL.window.create.menu"

///|
pub const PROP_WINDOW_CREATE_METAL_BOOLEAN : Bytes = b"SDL.window.create.metal"

///|
pub const PROP_WINDOW_CREATE_MINIMIZED_BOOLEAN : Bytes = b"SDL.window.create.minimized"

///|
pub const PROP_WINDOW_CREATE_MODAL_BOOLEAN : Bytes = b"SDL.window.create.modal"

///|
pub const PROP_WINDOW_CREATE_MOUSE_GRABBED_BOOLEAN : Bytes = b"SDL.window.create.mouse_grabbed"

///|
pub const PROP_WINDOW_CREATE_OPENGL_BOOLEAN : Bytes = b"SDL.window.create.opengl"

///|
pub const PROP_WINDOW_CREATE_PARENT_POINTER : Bytes = b"SDL.window.create.parent"

///|
pub const PROP_WINDOW_CREATE_RESIZABLE_BOOLEAN : Bytes = b"SDL.window.create.resizable"

///|
pub const PROP_WINDOW_CREATE_TITLE_STRING : Bytes = b"SDL.window.create.title"

///|
pub const PROP_WINDOW_CREATE_TOOLTIP_BOOLEAN : Bytes = b"SDL.window.create.tooltip"

///|
pub const PROP_WINDOW_CREATE_TRANSPARENT_BOOLEAN : Bytes = b"SDL.window.create.transparent"

///|
pub const PROP_WINDOW_CREATE_UTILITY_BOOLEAN : Bytes = b"SDL.window.create.utility"

///|
pub const PROP_WINDOW_CREATE_VISIONOS_SETTINGS_STRING : Bytes = b"SDL.window.create.visionos.settings"

///|
pub const PROP_WINDOW_CREATE_VULKAN_BOOLEAN : Bytes = b"SDL.window.create.vulkan"

///|
pub const PROP_WINDOW_CREATE_WAYLAND_CREATE_EGL_WINDOW_BOOLEAN : Bytes = b"SDL.window.create.wayland.create_egl_window"

///|
pub const PROP_WINDOW_CREATE_WAYLAND_SURFACE_ROLE_CUSTOM_BOOLEAN : Bytes = b"SDL.window.create.wayland.surface_role_custom"

///|
pub const PROP_WINDOW_CREATE_WAYLAND_WL_SURFACE_POINTER : Bytes = b"SDL.window.create.wayland.wl_surface"

///|
pub const PROP_WINDOW_CREATE_WIDTH_NUMBER : Bytes = b"SDL.window.create.width"

///|
pub const PROP_WINDOW_CREATE_WIN32_HWND_POINTER : Bytes = b"SDL.window.create.win32.hwnd"

///|
pub const PROP_WINDOW_CREATE_WIN32_PIXEL_FORMAT_HWND_POINTER : Bytes = b"SDL.window.create.win32.pixel_format_hwnd"

///|
pub const PROP_WINDOW_CREATE_WINDOWSCENE_POINTER : Bytes = b"SDL.window.create.uikit.windowscene"

///|
pub const PROP_WINDOW_CREATE_X11_WINDOW_NUMBER : Bytes = b"SDL.window.create.x11.window"

///|
pub const PROP_WINDOW_CREATE_X_NUMBER : Bytes = b"SDL.window.create.x"

///|
pub const PROP_WINDOW_CREATE_Y_NUMBER : Bytes = b"SDL.window.create.y"

///|
pub const PROP_WINDOW_EMSCRIPTEN_CANVAS_ID_STRING : Bytes = b"SDL.window.emscripten.canvas_id"

///|
pub const PROP_WINDOW_EMSCRIPTEN_KEYBOARD_ELEMENT_STRING : Bytes = b"SDL.window.emscripten.keyboard_element"

///|
pub const PROP_WINDOW_HDR_ENABLED_BOOLEAN : Bytes = b"SDL.window.HDR_enabled"

///|
pub const PROP_WINDOW_HDR_HEADROOM_FLOAT : Bytes = b"SDL.window.HDR_headroom"

///|
pub const PROP_WINDOW_KMSDRM_DEVICE_INDEX_NUMBER : Bytes = b"SDL.window.kmsdrm.dev_index"

///|
pub const PROP_WINDOW_KMSDRM_DRM_FD_NUMBER : Bytes = b"SDL.window.kmsdrm.drm_fd"

///|
pub const PROP_WINDOW_KMSDRM_GBM_DEVICE_POINTER : Bytes = b"SDL.window.kmsdrm.gbm_dev"

///|
pub const PROP_WINDOW_OPENVR_OVERLAY_ID_NUMBER : Bytes = b"SDL.window.openvr.overlay_id"

///|
pub const PROP_WINDOW_QNX_SURFACE_POINTER : Bytes = b"SDL.window.qnx.surface"

///|
pub const PROP_WINDOW_QNX_WINDOW_POINTER : Bytes = b"SDL.window.qnx.window"

///|
pub const PROP_WINDOW_SDR_WHITE_LEVEL_FLOAT : Bytes = b"SDL.window.SDR_white_level"

///|
pub const PROP_WINDOW_SHAPE_POINTER : Bytes = b"SDL.window.shape"

///|
pub const PROP_WINDOW_UIKIT_METAL_VIEW_TAG_NUMBER : Bytes = b"SDL.window.uikit.metal_view_tag"

///|
pub const PROP_WINDOW_UIKIT_OPENGL_FRAMEBUFFER_NUMBER : Bytes = b"SDL.window.uikit.opengl.framebuffer"

///|
pub const PROP_WINDOW_UIKIT_OPENGL_RENDERBUFFER_NUMBER : Bytes = b"SDL.window.uikit.opengl.renderbuffer"

///|
pub const PROP_WINDOW_UIKIT_OPENGL_RESOLVE_FRAMEBUFFER_NUMBER : Bytes = b"SDL.window.uikit.opengl.resolve_framebuffer"

///|
pub const PROP_WINDOW_UIKIT_WINDOW_POINTER : Bytes = b"SDL.window.uikit.window"

///|
pub const PROP_WINDOW_VISIONOS_SETTINGS_STRING : Bytes = b"SDL.window.visionos.settings"

///|
pub const PROP_WINDOW_VIVANTE_DISPLAY_POINTER : Bytes = b"SDL.window.vivante.display"

///|
pub const PROP_WINDOW_VIVANTE_SURFACE_POINTER : Bytes = b"SDL.window.vivante.surface"

///|
pub const PROP_WINDOW_VIVANTE_WINDOW_POINTER : Bytes = b"SDL.window.vivante.window"

///|
pub const PROP_WINDOW_WAYLAND_DISPLAY_POINTER : Bytes = b"SDL.window.wayland.display"

///|
pub const PROP_WINDOW_WAYLAND_EGL_WINDOW_POINTER : Bytes = b"SDL.window.wayland.egl_window"

///|
pub const PROP_WINDOW_WAYLAND_SURFACE_POINTER : Bytes = b"SDL.window.wayland.surface"

///|
pub const PROP_WINDOW_WAYLAND_VIEWPORT_POINTER : Bytes = b"SDL.window.wayland.viewport"

///|
pub const PROP_WINDOW_WAYLAND_XDG_POPUP_POINTER : Bytes = b"SDL.window.wayland.xdg_popup"

///|
pub const PROP_WINDOW_WAYLAND_XDG_POSITIONER_POINTER : Bytes = b"SDL.window.wayland.xdg_positioner"

///|
pub const PROP_WINDOW_WAYLAND_XDG_SURFACE_POINTER : Bytes = b"SDL.window.wayland.xdg_surface"

///|
pub const PROP_WINDOW_WAYLAND_XDG_TOPLEVEL_EXPORT_HANDLE_STRING : Bytes = b"SDL.window.wayland.xdg_toplevel_export_handle"

///|
pub const PROP_WINDOW_WAYLAND_XDG_TOPLEVEL_POINTER : Bytes = b"SDL.window.wayland.xdg_toplevel"

///|
pub const PROP_WINDOW_WIN32_HDC_POINTER : Bytes = b"SDL.window.win32.hdc"

///|
pub const PROP_WINDOW_WIN32_HWND_POINTER : Bytes = b"SDL.window.win32.hwnd"

///|
pub const PROP_WINDOW_WIN32_INSTANCE_POINTER : Bytes = b"SDL.window.win32.instance"

///|
pub const PROP_WINDOW_X11_DISPLAY_POINTER : Bytes = b"SDL.window.x11.display"

///|
pub const PROP_WINDOW_X11_SCREEN_NUMBER : Bytes = b"SDL.window.x11.screen"

///|
pub const PROP_WINDOW_X11_WINDOW_NUMBER : Bytes = b"SDL.window.x11.window"

///|
pub const WINDOW_ALWAYS_ON_TOP : UInt64 = 0x0000000000010000

///|
pub const WINDOW_BORDERLESS : UInt64 = 0x0000000000000010

///|
pub const WINDOW_EXTERNAL : UInt64 = 0x0000000000000800

///|
pub const WINDOW_FILL_DOCUMENT : UInt64 = 0x0000000000200000

///|
pub const WINDOW_FULLSCREEN : UInt64 = 0x0000000000000001

///|
pub const WINDOW_HIDDEN : UInt64 = 0x0000000000000008

///|
pub const WINDOW_HIGH_PIXEL_DENSITY : UInt64 = 0x0000000000002000

///|
pub const WINDOW_INPUT_FOCUS : UInt64 = 0x0000000000000200

///|
pub const WINDOW_KEYBOARD_GRABBED : UInt64 = 0x0000000000100000

///|
pub const WINDOW_MAXIMIZED : UInt64 = 0x0000000000000080

///|
pub const WINDOW_METAL : UInt64 = 0x0000000020000000

///|
pub const WINDOW_MINIMIZED : UInt64 = 0x0000000000000040

///|
pub const WINDOW_MODAL : UInt64 = 0x0000000000001000

///|
pub const WINDOW_MOUSE_CAPTURE : UInt64 = 0x0000000000004000

///|
pub const WINDOW_MOUSE_FOCUS : UInt64 = 0x0000000000000400

///|
pub const WINDOW_MOUSE_GRABBED : UInt64 = 0x0000000000000100

///|
pub const WINDOW_MOUSE_RELATIVE_MODE : UInt64 = 0x0000000000008000

///|
pub const WINDOW_NOT_FOCUSABLE : UInt64 = 0x0000000080000000

///|
pub const WINDOW_OCCLUDED : UInt64 = 0x0000000000000004

///|
pub const WINDOW_OPENGL : UInt64 = 0x0000000000000002

///|
pub const WINDOW_POPUP_MENU : UInt64 = 0x0000000000080000

///|
pub const WINDOW_RESIZABLE : UInt64 = 0x0000000000000020

///|
pub const WINDOW_SURFACE_VSYNC_ADAPTIVE : Int = -1

///|
pub const WINDOW_SURFACE_VSYNC_DISABLED : UInt64 = 0

///|
pub const WINDOW_TOOLTIP : UInt64 = 0x0000000000040000

///|
pub const WINDOW_TRANSPARENT : UInt64 = 0x0000000040000000

///|
pub const WINDOW_UTILITY : UInt64 = 0x0000000000020000

///|
pub const WINDOW_VULKAN : UInt64 = 0x0000000010000000

///|
#borrow(title)
pub extern "c" fn create_window(title : Bytes, w : Int, h : Int, flags : UInt64) -> Window = "moonbit_sdl_create_window"

///|
pub extern "c" fn create_window_with_properties(props : UInt) -> Window = "moonbit_sdl_create_window_with_properties"

///|
#borrow(window)
pub extern "c" fn get_window_id(window : Window) -> UInt = "moonbit_sdl_get_window_id"

///|
pub extern "c" fn get_window_from_id(id : UInt) -> Window = "moonbit_sdl_get_window_from_id"

///|
#borrow(window)
pub extern "c" fn get_window_properties(window : Window) -> UInt = "moonbit_sdl_get_window_properties"

///|
#borrow(window)
pub extern "c" fn get_window_flags(window : Window) -> UInt64 = "moonbit_sdl_get_window_flags"

///|
#borrow(window, title)
pub extern "c" fn set_window_title(window : Window, title : Bytes) -> Bool = "moonbit_sdl_set_window_title"

///|
#borrow(window)
pub extern "c" fn get_window_title(window : Window) -> Bytes = "moonbit_sdl_get_window_title"

///|
#borrow(window)
pub extern "c" fn set_window_position(window : Window, x : Int, y : Int) -> Bool = "moonbit_sdl_set_window_position"

///|
#borrow(window, x, y)
pub extern "c" fn get_window_position(window : Window, x : Ref[Int], y : Ref[Int]) -> Bool = "moonbit_sdl_get_window_position"

///|
#borrow(window)
pub extern "c" fn set_window_size(window : Window, w : Int, h : Int) -> Bool = "moonbit_sdl_set_window_size"

///|
#borrow(window, w, h)
pub extern "c" fn get_window_size(window : Window, w : Ref[Int], h : Ref[Int]) -> Bool = "moonbit_sdl_get_window_size"

///|
#borrow(window, w, h)
pub extern "c" fn get_window_size_in_pixels(window : Window, w : Ref[Int], h : Ref[Int]) -> Bool = "moonbit_sdl_get_window_size_in_pixels"

///|
#borrow(window)
pub extern "c" fn set_window_minimum_size(window : Window, min_w : Int, min_h : Int) -> Bool = "moonbit_sdl_set_window_minimum_size"

///|
#borrow(window, w, h)
pub extern "c" fn get_window_minimum_size(window : Window, w : Ref[Int], h : Ref[Int]) -> Bool = "moonbit_sdl_get_window_minimum_size"

///|
#borrow(window)
pub extern "c" fn set_window_maximum_size(window : Window, max_w : Int, max_h : Int) -> Bool = "moonbit_sdl_set_window_maximum_size"

///|
#borrow(window, w, h)
pub extern "c" fn get_window_maximum_size(window : Window, w : Ref[Int], h : Ref[Int]) -> Bool = "moonbit_sdl_get_window_maximum_size"

///|
#borrow(window)
pub extern "c" fn set_window_bordered(window : Window, bordered : Bool) -> Bool = "moonbit_sdl_set_window_bordered"

///|
#borrow(window)
pub extern "c" fn set_window_resizable(window : Window, resizable : Bool) -> Bool = "moonbit_sdl_set_window_resizable"

///|
#borrow(window)
pub extern "c" fn set_window_always_on_top(window : Window, on_top : Bool) -> Bool = "moonbit_sdl_set_window_always_on_top"

///|
#borrow(window)
pub extern "c" fn show_window(window : Window) -> Bool = "moonbit_sdl_show_window"

///|
#borrow(window)
pub extern "c" fn hide_window(window : Window) -> Bool = "moonbit_sdl_hide_window"

///|
#borrow(window)
pub extern "c" fn raise_window(window : Window) -> Bool = "moonbit_sdl_raise_window"

///|
#borrow(window)
pub extern "c" fn maximize_window(window : Window) -> Bool = "moonbit_sdl_maximize_window"

///|
#borrow(window)
pub extern "c" fn minimize_window(window : Window) -> Bool = "moonbit_sdl_minimize_window"

///|
#borrow(window)
pub extern "c" fn restore_window(window : Window) -> Bool = "moonbit_sdl_restore_window"

///|
#borrow(window)
pub extern "c" fn set_window_fullscreen(window : Window, fullscreen : Bool) -> Bool = "moonbit_sdl_set_window_fullscreen"

///|
#borrow(window)
pub extern "c" fn set_window_keyboard_grab(window : Window, grabbed : Bool) -> Bool = "moonbit_sdl_set_window_keyboard_grab"

///|
#borrow(window)
pub extern "c" fn set_window_mouse_grab(window : Window, grabbed : Bool) -> Bool = "moonbit_sdl_set_window_mouse_grab"

///|
#borrow(window)
pub extern "c" fn get_window_keyboard_grab(window : Window) -> Bool = "moonbit_sdl_get_window_keyboard_grab"

///|
#borrow(window)
pub extern "c" fn get_window_mouse_grab(window : Window) -> Bool = "moonbit_sdl_get_window_mouse_grab"

///|
#borrow(window)
pub extern "c" fn set_window_opacity(window : Window, opacity : Float) -> Bool = "moonbit_sdl_set_window_opacity"

///|
#borrow(window)
pub extern "c" fn get_window_opacity(window : Window) -> Float = "moonbit_sdl_get_window_opacity"

///|
#borrow(window)
pub extern "c" fn show_window_system_menu(window : Window, x : Int, y : Int) -> Bool = "moonbit_sdl_show_window_system_menu"

///|
#borrow(window)
pub extern "c" fn destroy_window(window : Window) = "moonbit_sdl_destroy_window"
