// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL.h"
#include <moonbit.h>

moonbit_bytes_t moonbit_cstring_to_bytes(const char *str);

moonbit_bytes_t moonbit_sdl_get_error(void) {
  return moonbit_cstring_to_bytes(SDL_GetError());
}
