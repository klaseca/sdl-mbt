// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL_init.h"
#include <moonbit.h>
#include <stdint.h>

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_init_lib(SDL_InitFlags flags) {
  return SDL_Init(flags);
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_quit(void) {
  SDL_Quit();
}
