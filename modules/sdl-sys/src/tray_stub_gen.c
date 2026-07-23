// Generated file. Do not edit by hand.

#include <SDL3/SDL_tray.h>
#include <moonbit.h>
#include <stdint.h>
#include <stddef.h>

moonbit_bytes_t moonbit_cstring_to_bytes_sdl(const char *str);

typedef struct {
  SDL_Tray *ptr;
  int32_t owns_ptr;
  void *native_owner;
  void (*release_native_owner)(void *);
} moonbit_sdl_tray_resource_t;

static void moonbit_sdl_tray_release(void *ptr) {
  if (ptr != NULL) SDL_DestroyTray((SDL_Tray *)ptr);
}

static void moonbit_sdl_tray_finalize(void *self) {
  moonbit_sdl_tray_resource_t *resource = (moonbit_sdl_tray_resource_t *)self;
  if (resource == NULL) return;
  if (resource->owns_ptr && resource->ptr != NULL) moonbit_sdl_tray_release(resource->ptr);
  resource->ptr = NULL;
  resource->owns_ptr = 0;
  if (resource->native_owner != NULL && resource->release_native_owner != NULL) {
    resource->release_native_owner(resource->native_owner);
  }
  resource->native_owner = NULL;
  resource->release_native_owner = NULL;
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_destroy_tray(void *self) {
  moonbit_sdl_tray_finalize(self);
}

SDL_Tray *moonbit_sdl_tray_ptr(void *self) {
  moonbit_sdl_tray_resource_t *resource = (moonbit_sdl_tray_resource_t *)self;
  return resource == NULL ? NULL : resource->ptr;
}

static void *moonbit_sdl_tray_make(SDL_Tray *ptr, int32_t owns_ptr) {
  moonbit_sdl_tray_resource_t *resource = (moonbit_sdl_tray_resource_t *)moonbit_make_external_object(
    moonbit_sdl_tray_finalize, sizeof(moonbit_sdl_tray_resource_t)
  );
  resource->ptr = ptr;
  resource->owns_ptr = owns_ptr;
  resource->native_owner = NULL;
  resource->release_native_owner = NULL;
  return resource;
}

void *moonbit_sdl_tray_make_owned(SDL_Tray *ptr) {
  return moonbit_sdl_tray_make(ptr, 1);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_tray_is_null(void *self) {
  return moonbit_sdl_tray_ptr(self) == NULL;
}

MOONBIT_FFI_EXPORT
void * moonbit_sdl_create_tray(moonbit_bytes_t tooltip) {
  return moonbit_sdl_tray_make_owned(SDL_CreateTray(NULL, (const char *)tooltip));
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_set_tray_tooltip(void * tray, moonbit_bytes_t tooltip) {
  SDL_SetTrayTooltip(moonbit_sdl_tray_ptr(tray), (const char *)tooltip);
}

MOONBIT_FFI_EXPORT
SDL_TrayMenu * moonbit_sdl_create_tray_menu(void * tray) {
  return SDL_CreateTrayMenu(moonbit_sdl_tray_ptr(tray));
}

MOONBIT_FFI_EXPORT
SDL_TrayMenu * moonbit_sdl_create_tray_submenu(SDL_TrayEntry * entry) {
  return SDL_CreateTraySubmenu(entry);
}

MOONBIT_FFI_EXPORT
SDL_TrayMenu * moonbit_sdl_get_tray_menu(void * tray) {
  return SDL_GetTrayMenu(moonbit_sdl_tray_ptr(tray));
}

MOONBIT_FFI_EXPORT
SDL_TrayMenu * moonbit_sdl_get_tray_submenu(SDL_TrayEntry * entry) {
  return SDL_GetTraySubmenu(entry);
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_remove_tray_entry(SDL_TrayEntry * entry) {
  SDL_RemoveTrayEntry(entry);
}

MOONBIT_FFI_EXPORT
SDL_TrayEntry * moonbit_sdl_insert_tray_entry_at(SDL_TrayMenu * menu, int32_t pos, moonbit_bytes_t label, SDL_TrayEntryFlags flags) {
  return SDL_InsertTrayEntryAt(menu, pos, (Moonbit_array_length(label) == 0 ? NULL : (const char *)label), flags);
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_set_tray_entry_label(SDL_TrayEntry * entry, moonbit_bytes_t label) {
  SDL_SetTrayEntryLabel(entry, (const char *)label);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_get_tray_entry_label(SDL_TrayEntry * entry) {
  return moonbit_cstring_to_bytes_sdl(SDL_GetTrayEntryLabel(entry));
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_set_tray_entry_checked(SDL_TrayEntry * entry, int32_t checked) {
  SDL_SetTrayEntryChecked(entry, checked);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_tray_entry_checked(SDL_TrayEntry * entry) {
  return SDL_GetTrayEntryChecked(entry);
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_set_tray_entry_enabled(SDL_TrayEntry * entry, int32_t enabled) {
  SDL_SetTrayEntryEnabled(entry, enabled);
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_get_tray_entry_enabled(SDL_TrayEntry * entry) {
  return SDL_GetTrayEntryEnabled(entry);
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_click_tray_entry(SDL_TrayEntry * entry) {
  SDL_ClickTrayEntry(entry);
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_update_trays(void) {
  SDL_UpdateTrays();
}
