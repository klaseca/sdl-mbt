#include <stddef.h>
#include <stdint.h>
#include <moonbit.h>

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_pointer_is_null(void *self) {
  return self == NULL;
}
