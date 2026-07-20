// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL_clipboard.h"
#include <moonbit.h>
#include <stdint.h>

moonbit_bytes_t moonbit_cstring_to_bytes_sdl(const char *str);

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_set_clipboard_text(moonbit_bytes_t text) {
  return SDL_SetClipboardText((const char *)text);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_get_clipboard_text(void) {
  char *result = SDL_GetClipboardText();
  moonbit_bytes_t bytes = moonbit_cstring_to_bytes_sdl(result);
  SDL_free(result);
  return bytes;
}

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_has_clipboard_text(void) {
  return SDL_HasClipboardText();
}
