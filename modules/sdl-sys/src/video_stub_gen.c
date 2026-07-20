// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL_video.h"
#include <moonbit.h>
#include <stdint.h>
#include <stddef.h>

moonbit_bytes_t moonbit_cstring_to_bytes_sdl(const char *str);

typedef struct {
  SDL_Window *ptr;
  int32_t owns_ptr;
  void *native_owner;
  void (*release_native_owner)(void *);
} moonbit_sdl_window_resource_t;

static void moonbit_sdl_window_release(void *ptr) {
  if (ptr != NULL) SDL_DestroyWindow((SDL_Window *)ptr);
}

static void moonbit_sdl_window_finalize(void *self) {
  moonbit_sdl_window_resource_t *resource = (moonbit_sdl_window_resource_t *)self;
  if (resource == NULL) return;
  if (resource->owns_ptr && resource->ptr != NULL) moonbit_sdl_window_release(resource->ptr);
  resource->ptr = NULL;
  resource->owns_ptr = 0;
  if (resource->native_owner != NULL && resource->release_native_owner != NULL) {
    resource->release_native_owner(resource->native_owner);
  }
  resource->native_owner = NULL;
  resource->release_native_owner = NULL;
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_destroy_window(void *self) {
  moonbit_sdl_window_finalize(self);
}

SDL_Window *moonbit_sdl_window_ptr(void *self) {
  moonbit_sdl_window_resource_t *resource = (moonbit_sdl_window_resource_t *)self;
  return resource == NULL ? NULL : resource->ptr;
}

static void *moonbit_sdl_window_make(SDL_Window *ptr, int32_t owns_ptr) {
  moonbit_sdl_window_resource_t *resource = (moonbit_sdl_window_resource_t *)moonbit_make_external_object(
    moonbit_sdl_window_finalize, sizeof(moonbit_sdl_window_resource_t)
  );
  resource->ptr = ptr;
  resource->owns_ptr = owns_ptr;
  resource->native_owner = NULL;
  resource->release_native_owner = NULL;
  return resource;
}

void *moonbit_sdl_window_make_owned(SDL_Window *ptr) {
  return moonbit_sdl_window_make(ptr, 1);
}

void *moonbit_sdl_window_make_unmanaged(SDL_Window *ptr) {
  return moonbit_sdl_window_make(ptr, 0);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_window_is_null(void *self) {
  return moonbit_sdl_window_ptr(self) == NULL;
}

MOONBIT_FFI_EXPORT
void * moonbit_sdl_create_window(moonbit_bytes_t title, int32_t w, int32_t h, SDL_WindowFlags flags) {
  return moonbit_sdl_window_make_owned(SDL_CreateWindow((const char *)title, w, h, flags));
}

MOONBIT_FFI_EXPORT
void * moonbit_sdl_create_window_with_properties(SDL_PropertiesID props) {
  return moonbit_sdl_window_make_owned(SDL_CreateWindowWithProperties(props));
}

MOONBIT_FFI_EXPORT
SDL_WindowID moonbit_sdl_get_window_id(void * window) {
  return SDL_GetWindowID(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
void * moonbit_sdl_get_window_from_id(SDL_WindowID id) {
  return moonbit_sdl_window_make_unmanaged(SDL_GetWindowFromID(id));
}

MOONBIT_FFI_EXPORT
SDL_PropertiesID moonbit_sdl_get_window_properties(void * window) {
  return SDL_GetWindowProperties(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
SDL_WindowFlags moonbit_sdl_get_window_flags(void * window) {
  return SDL_GetWindowFlags(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_title(void * window, moonbit_bytes_t title) {
  return SDL_SetWindowTitle(moonbit_sdl_window_ptr(window), (const char *)title);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_get_window_title(void * window) {
  return moonbit_cstring_to_bytes_sdl(SDL_GetWindowTitle(moonbit_sdl_window_ptr(window)));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_position(void * window, int32_t x, int32_t y) {
  return SDL_SetWindowPosition(moonbit_sdl_window_ptr(window), x, y);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_window_position(void * window, int32_t * x, int32_t * y) {
  int x_value = 0;
  int y_value = 0;
  int32_t result = SDL_GetWindowPosition(moonbit_sdl_window_ptr(window), &x_value, &y_value);
  if (x != NULL) *x = x_value;
  if (y != NULL) *y = y_value;
  return result;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_size(void * window, int32_t w, int32_t h) {
  return SDL_SetWindowSize(moonbit_sdl_window_ptr(window), w, h);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_window_size(void * window, int32_t * w, int32_t * h) {
  int w_value = 0;
  int h_value = 0;
  int32_t result = SDL_GetWindowSize(moonbit_sdl_window_ptr(window), &w_value, &h_value);
  if (w != NULL) *w = w_value;
  if (h != NULL) *h = h_value;
  return result;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_window_size_in_pixels(void * window, int32_t * w, int32_t * h) {
  int w_value = 0;
  int h_value = 0;
  int32_t result = SDL_GetWindowSizeInPixels(moonbit_sdl_window_ptr(window), &w_value, &h_value);
  if (w != NULL) *w = w_value;
  if (h != NULL) *h = h_value;
  return result;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_minimum_size(void * window, int32_t min_w, int32_t min_h) {
  return SDL_SetWindowMinimumSize(moonbit_sdl_window_ptr(window), min_w, min_h);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_window_minimum_size(void * window, int32_t * w, int32_t * h) {
  int w_value = 0;
  int h_value = 0;
  int32_t result = SDL_GetWindowMinimumSize(moonbit_sdl_window_ptr(window), &w_value, &h_value);
  if (w != NULL) *w = w_value;
  if (h != NULL) *h = h_value;
  return result;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_maximum_size(void * window, int32_t max_w, int32_t max_h) {
  return SDL_SetWindowMaximumSize(moonbit_sdl_window_ptr(window), max_w, max_h);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_window_maximum_size(void * window, int32_t * w, int32_t * h) {
  int w_value = 0;
  int h_value = 0;
  int32_t result = SDL_GetWindowMaximumSize(moonbit_sdl_window_ptr(window), &w_value, &h_value);
  if (w != NULL) *w = w_value;
  if (h != NULL) *h = h_value;
  return result;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_bordered(void * window, int32_t bordered) {
  return SDL_SetWindowBordered(moonbit_sdl_window_ptr(window), bordered);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_resizable(void * window, int32_t resizable) {
  return SDL_SetWindowResizable(moonbit_sdl_window_ptr(window), resizable);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_always_on_top(void * window, int32_t on_top) {
  return SDL_SetWindowAlwaysOnTop(moonbit_sdl_window_ptr(window), on_top);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_show_window(void * window) {
  return SDL_ShowWindow(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_hide_window(void * window) {
  return SDL_HideWindow(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_raise_window(void * window) {
  return SDL_RaiseWindow(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_maximize_window(void * window) {
  return SDL_MaximizeWindow(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_minimize_window(void * window) {
  return SDL_MinimizeWindow(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_restore_window(void * window) {
  return SDL_RestoreWindow(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_fullscreen(void * window, int32_t fullscreen) {
  return SDL_SetWindowFullscreen(moonbit_sdl_window_ptr(window), fullscreen);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_keyboard_grab(void * window, int32_t grabbed) {
  return SDL_SetWindowKeyboardGrab(moonbit_sdl_window_ptr(window), grabbed);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_mouse_grab(void * window, int32_t grabbed) {
  return SDL_SetWindowMouseGrab(moonbit_sdl_window_ptr(window), grabbed);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_window_keyboard_grab(void * window) {
  return SDL_GetWindowKeyboardGrab(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_window_mouse_grab(void * window) {
  return SDL_GetWindowMouseGrab(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_window_opacity(void * window, float opacity) {
  return SDL_SetWindowOpacity(moonbit_sdl_window_ptr(window), opacity);
}

MOONBIT_FFI_EXPORT
float moonbit_sdl_get_window_opacity(void * window) {
  return SDL_GetWindowOpacity(moonbit_sdl_window_ptr(window));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_show_window_system_menu(void * window, int32_t x, int32_t y) {
  return SDL_ShowWindowSystemMenu(moonbit_sdl_window_ptr(window), x, y);
}
