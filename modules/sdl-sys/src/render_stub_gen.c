// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL.h"
#include <moonbit.h>
#include <stddef.h>
#include <stdint.h>

typedef struct {
  SDL_Renderer *ptr;
} moonbit_sdl_renderer_resource_t;

static SDL_Renderer *moonbit_sdl_renderer_ptr(moonbit_sdl_renderer_resource_t *self) {
  return self == NULL ? NULL : self->ptr;
}

void moonbit_sdl_destroy_renderer(void *self) {
  moonbit_sdl_renderer_resource_t *resource = (moonbit_sdl_renderer_resource_t *)self;
  if (resource == NULL || resource->ptr == NULL) {
    return;
  }
  SDL_DestroyRenderer(resource->ptr);
  resource->ptr = NULL;
}

static moonbit_sdl_renderer_resource_t *moonbit_sdl_renderer_make(SDL_Renderer *ptr) {
  moonbit_sdl_renderer_resource_t *resource = (moonbit_sdl_renderer_resource_t *)moonbit_make_external_object(
    moonbit_sdl_destroy_renderer,
    sizeof(moonbit_sdl_renderer_resource_t)
  );
  resource->ptr = ptr;
  return resource;
}

int32_t moonbit_sdl_renderer_is_null(moonbit_sdl_renderer_resource_t *self) {
  return moonbit_sdl_renderer_ptr(self) == NULL;
}

typedef struct {
  SDL_Texture *ptr;
} moonbit_sdl_texture_resource_t;

static SDL_Texture *moonbit_sdl_texture_ptr(moonbit_sdl_texture_resource_t *self) {
  return self == NULL ? NULL : self->ptr;
}

void moonbit_sdl_destroy_texture(void *self) {
  moonbit_sdl_texture_resource_t *resource = (moonbit_sdl_texture_resource_t *)self;
  if (resource == NULL || resource->ptr == NULL) {
    return;
  }
  SDL_DestroyTexture(resource->ptr);
  resource->ptr = NULL;
}

static moonbit_sdl_texture_resource_t *moonbit_sdl_texture_make(SDL_Texture *ptr) {
  moonbit_sdl_texture_resource_t *resource = (moonbit_sdl_texture_resource_t *)moonbit_make_external_object(
    moonbit_sdl_destroy_texture,
    sizeof(moonbit_sdl_texture_resource_t)
  );
  resource->ptr = ptr;
  return resource;
}

int32_t moonbit_sdl_texture_is_null(moonbit_sdl_texture_resource_t *self) {
  return moonbit_sdl_texture_ptr(self) == NULL;
}

typedef struct {
  SDL_Window *ptr;
} moonbit_sdl_window_resource_t;

static SDL_Window *moonbit_sdl_window_ptr(moonbit_sdl_window_resource_t *self) {
  return self == NULL ? NULL : self->ptr;
}

moonbit_sdl_renderer_resource_t * moonbit_sdl_create_renderer(moonbit_sdl_window_resource_t * window, moonbit_bytes_t name) {
  return moonbit_sdl_renderer_make(SDL_CreateRenderer(moonbit_sdl_window_ptr(window), (Moonbit_array_length(name) == 0 ? NULL : (const char *)name)));
}

int32_t moonbit_sdl_get_current_render_output_size(moonbit_sdl_renderer_resource_t * renderer, int32_t * w, int32_t * h) {
  int w_value = 0;
  int h_value = 0;
  int32_t result = SDL_GetCurrentRenderOutputSize(moonbit_sdl_renderer_ptr(renderer), &w_value, &h_value);
  if (w != NULL) *w = (int32_t)w_value;
  if (h != NULL) *h = (int32_t)h_value;
  return result;
}

moonbit_sdl_texture_resource_t * moonbit_sdl_create_texture(moonbit_sdl_renderer_resource_t * renderer, SDL_PixelFormat format, SDL_TextureAccess access, int w, int h) {
  return moonbit_sdl_texture_make(SDL_CreateTexture(moonbit_sdl_renderer_ptr(renderer), format, access, w, h));
}

int32_t moonbit_sdl_get_texture_size(moonbit_sdl_texture_resource_t * texture, float * w, float * h) {
  float w_value = 0.0f;
  float h_value = 0.0f;
  int32_t result = SDL_GetTextureSize(moonbit_sdl_texture_ptr(texture), &w_value, &h_value);
  if (w != NULL) *w = w_value;
  if (h != NULL) *h = h_value;
  return result;
}

int32_t moonbit_sdl_set_texture_color_mod(moonbit_sdl_texture_resource_t * texture, Uint8 r, Uint8 g, Uint8 b) {
  return SDL_SetTextureColorMod(moonbit_sdl_texture_ptr(texture), r, g, b);
}

int32_t moonbit_sdl_set_texture_alpha_mod(moonbit_sdl_texture_resource_t * texture, Uint8 alpha) {
  return SDL_SetTextureAlphaMod(moonbit_sdl_texture_ptr(texture), alpha);
}

int32_t moonbit_sdl_set_texture_blend_mode(moonbit_sdl_texture_resource_t * texture, SDL_BlendMode blendMode) {
  return SDL_SetTextureBlendMode(moonbit_sdl_texture_ptr(texture), blendMode);
}

int32_t moonbit_sdl_update_texture_ffi(moonbit_sdl_texture_resource_t * texture, moonbit_bytes_t rect, int32_t has_rect, moonbit_bytes_t pixels, int pitch) {
  return SDL_UpdateTexture(moonbit_sdl_texture_ptr(texture), has_rect ? (const SDL_Rect *)rect : NULL, (const void *)pixels, pitch);
}

int32_t moonbit_sdl_lock_texture_ffi(moonbit_sdl_texture_resource_t * texture, moonbit_bytes_t rect, int32_t has_rect, void ** pixels, int32_t * pitch) {
  void *pixels_value = NULL;
  int pitch_value = 0;
  int32_t result = SDL_LockTexture(moonbit_sdl_texture_ptr(texture), has_rect ? (const SDL_Rect *)rect : NULL, &pixels_value, &pitch_value);
  if (pixels != NULL) *pixels = pixels_value;
  if (pitch != NULL) *pitch = (int32_t)pitch_value;
  return result;
}

void moonbit_sdl_unlock_texture(moonbit_sdl_texture_resource_t * texture) {
  SDL_UnlockTexture(moonbit_sdl_texture_ptr(texture));
}

int32_t moonbit_sdl_set_render_draw_color(moonbit_sdl_renderer_resource_t * renderer, Uint8 r, Uint8 g, Uint8 b, Uint8 a) {
  return SDL_SetRenderDrawColor(moonbit_sdl_renderer_ptr(renderer), r, g, b, a);
}

int32_t moonbit_sdl_render_clear(moonbit_sdl_renderer_resource_t * renderer) {
  return SDL_RenderClear(moonbit_sdl_renderer_ptr(renderer));
}

int32_t moonbit_sdl_render_fill_rect_ffi(moonbit_sdl_renderer_resource_t * renderer, moonbit_bytes_t rect) {
  return SDL_RenderFillRect(moonbit_sdl_renderer_ptr(renderer), (const SDL_FRect *)rect);
}

int32_t moonbit_sdl_render_texture_ffi(moonbit_sdl_renderer_resource_t * renderer, moonbit_sdl_texture_resource_t * texture, moonbit_bytes_t srcrect, moonbit_bytes_t dstrect) {
  return SDL_RenderTexture(moonbit_sdl_renderer_ptr(renderer), moonbit_sdl_texture_ptr(texture), (const SDL_FRect *)srcrect, (const SDL_FRect *)dstrect);
}

int32_t moonbit_sdl_render_present(moonbit_sdl_renderer_resource_t * renderer) {
  return SDL_RenderPresent(moonbit_sdl_renderer_ptr(renderer));
}
