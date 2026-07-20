// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL_error.h"
#include <moonbit.h>

moonbit_bytes_t moonbit_cstring_to_bytes_sdl(const char *str);

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_get_error(void) {
  return moonbit_cstring_to_bytes_sdl(SDL_GetError());
}
