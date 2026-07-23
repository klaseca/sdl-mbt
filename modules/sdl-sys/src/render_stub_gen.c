// Generated file. Do not edit by hand.

#include <SDL3/SDL_render.h>
#include <moonbit.h>
#include <stdint.h>
#include <stddef.h>

typedef struct {
  SDL_Renderer *ptr;
  int32_t owns_ptr;
  void *native_owner;
  void (*release_native_owner)(void *);
} moonbit_sdl_renderer_resource_t;

static void moonbit_sdl_renderer_release(void *ptr) {
  if (ptr != NULL) SDL_DestroyRenderer((SDL_Renderer *)ptr);
}

static void moonbit_sdl_renderer_finalize(void *self) {
  moonbit_sdl_renderer_resource_t *resource = (moonbit_sdl_renderer_resource_t *)self;
  if (resource == NULL) return;
  if (resource->owns_ptr && resource->ptr != NULL) moonbit_sdl_renderer_release(resource->ptr);
  resource->ptr = NULL;
  resource->owns_ptr = 0;
  if (resource->native_owner != NULL && resource->release_native_owner != NULL) {
    resource->release_native_owner(resource->native_owner);
  }
  resource->native_owner = NULL;
  resource->release_native_owner = NULL;
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_destroy_renderer(void *self) {
  moonbit_sdl_renderer_finalize(self);
}

SDL_Renderer *moonbit_sdl_renderer_ptr(void *self) {
  moonbit_sdl_renderer_resource_t *resource = (moonbit_sdl_renderer_resource_t *)self;
  return resource == NULL ? NULL : resource->ptr;
}

static void *moonbit_sdl_renderer_make(SDL_Renderer *ptr, int32_t owns_ptr) {
  moonbit_sdl_renderer_resource_t *resource = (moonbit_sdl_renderer_resource_t *)moonbit_make_external_object(
    moonbit_sdl_renderer_finalize, sizeof(moonbit_sdl_renderer_resource_t)
  );
  resource->ptr = ptr;
  resource->owns_ptr = owns_ptr;
  resource->native_owner = NULL;
  resource->release_native_owner = NULL;
  return resource;
}

void *moonbit_sdl_renderer_make_owned(SDL_Renderer *ptr) {
  return moonbit_sdl_renderer_make(ptr, 1);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_renderer_is_null(void *self) {
  return moonbit_sdl_renderer_ptr(self) == NULL;
}

typedef struct {
  SDL_Texture *ptr;
  int32_t owns_ptr;
  void *native_owner;
  void (*release_native_owner)(void *);
} moonbit_sdl_texture_resource_t;

static void moonbit_sdl_texture_release(void *ptr) {
  if (ptr != NULL) SDL_DestroyTexture((SDL_Texture *)ptr);
}

static void moonbit_sdl_texture_finalize(void *self) {
  moonbit_sdl_texture_resource_t *resource = (moonbit_sdl_texture_resource_t *)self;
  if (resource == NULL) return;
  if (resource->owns_ptr && resource->ptr != NULL) moonbit_sdl_texture_release(resource->ptr);
  resource->ptr = NULL;
  resource->owns_ptr = 0;
  if (resource->native_owner != NULL && resource->release_native_owner != NULL) {
    resource->release_native_owner(resource->native_owner);
  }
  resource->native_owner = NULL;
  resource->release_native_owner = NULL;
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_destroy_texture(void *self) {
  moonbit_sdl_texture_finalize(self);
}

SDL_Texture *moonbit_sdl_texture_ptr(void *self) {
  moonbit_sdl_texture_resource_t *resource = (moonbit_sdl_texture_resource_t *)self;
  return resource == NULL ? NULL : resource->ptr;
}

static void *moonbit_sdl_texture_make(SDL_Texture *ptr, int32_t owns_ptr) {
  moonbit_sdl_texture_resource_t *resource = (moonbit_sdl_texture_resource_t *)moonbit_make_external_object(
    moonbit_sdl_texture_finalize, sizeof(moonbit_sdl_texture_resource_t)
  );
  resource->ptr = ptr;
  resource->owns_ptr = owns_ptr;
  resource->native_owner = NULL;
  resource->release_native_owner = NULL;
  return resource;
}

void *moonbit_sdl_texture_make_owned(SDL_Texture *ptr) {
  return moonbit_sdl_texture_make(ptr, 1);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_texture_is_null(void *self) {
  return moonbit_sdl_texture_ptr(self) == NULL;
}

SDL_Window *moonbit_sdl_window_ptr(void *self);

MOONBIT_FFI_EXPORT
void * moonbit_sdl_create_renderer(void * window, moonbit_bytes_t name) {
  return moonbit_sdl_renderer_make_owned(SDL_CreateRenderer(moonbit_sdl_window_ptr(window), (const char *)name));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_current_render_output_size(void * renderer, int32_t * w, int32_t * h) {
  int w_value = 0;
  int h_value = 0;
  int32_t result = SDL_GetCurrentRenderOutputSize(moonbit_sdl_renderer_ptr(renderer), &w_value, &h_value);
  if (w != NULL) *w = w_value;
  if (h != NULL) *h = h_value;
  return result;
}

MOONBIT_FFI_EXPORT
void * moonbit_sdl_create_texture(void * renderer, SDL_PixelFormat format, SDL_TextureAccess access, int32_t w, int32_t h) {
  return moonbit_sdl_texture_make_owned(SDL_CreateTexture(moonbit_sdl_renderer_ptr(renderer), format, access, w, h));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_texture_size(void * texture, float * w, float * h) {
  float w_value = 0;
  float h_value = 0;
  int32_t result = SDL_GetTextureSize(moonbit_sdl_texture_ptr(texture), &w_value, &h_value);
  if (w != NULL) *w = w_value;
  if (h != NULL) *h = h_value;
  return result;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_texture_color_mod(void * texture, Uint8 r, Uint8 g, Uint8 b) {
  return SDL_SetTextureColorMod(moonbit_sdl_texture_ptr(texture), r, g, b);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_texture_alpha_mod(void * texture, Uint8 alpha) {
  return SDL_SetTextureAlphaMod(moonbit_sdl_texture_ptr(texture), alpha);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_texture_blend_mode(void * texture, SDL_BlendMode blendMode) {
  return SDL_SetTextureBlendMode(moonbit_sdl_texture_ptr(texture), blendMode);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_update_texture_ffi(void * texture, moonbit_bytes_t rect, int32_t has_rect, moonbit_bytes_t pixels, int32_t pitch) {
  return SDL_UpdateTexture(moonbit_sdl_texture_ptr(texture), has_rect ? ((const SDL_Rect *)rect) : NULL, ((const void *)pixels), pitch);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_lock_texture_ffi(void * texture, moonbit_bytes_t rect, int32_t has_rect, void ** pixels, int32_t * pitch) {
  void * pixels_value = NULL;
  int pitch_value = 0;
  int32_t result = SDL_LockTexture(moonbit_sdl_texture_ptr(texture), has_rect ? ((const SDL_Rect *)rect) : NULL, &pixels_value, &pitch_value);
  if (pixels != NULL) *pixels = pixels_value;
  if (pitch != NULL) *pitch = pitch_value;
  return result;
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_unlock_texture(void * texture) {
  SDL_UnlockTexture(moonbit_sdl_texture_ptr(texture));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_render_draw_color(void * renderer, Uint8 r, Uint8 g, Uint8 b, Uint8 a) {
  return SDL_SetRenderDrawColor(moonbit_sdl_renderer_ptr(renderer), r, g, b, a);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_render_clear(void * renderer) {
  return SDL_RenderClear(moonbit_sdl_renderer_ptr(renderer));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_render_fill_rect_ffi(void * renderer, moonbit_bytes_t rect) {
  return SDL_RenderFillRect(moonbit_sdl_renderer_ptr(renderer), ((const SDL_FRect *)rect));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_render_texture_ffi(void * renderer, void * texture, moonbit_bytes_t srcrect, moonbit_bytes_t dstrect) {
  return SDL_RenderTexture(moonbit_sdl_renderer_ptr(renderer), moonbit_sdl_texture_ptr(texture), ((const SDL_FRect *)srcrect), ((const SDL_FRect *)dstrect));
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_render_present(void * renderer) {
  return SDL_RenderPresent(moonbit_sdl_renderer_ptr(renderer));
}
