// Generated file. Do not edit by hand.

#include <moonbit.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

MOONBIT_FFI_EXPORT
int32_t moonbit_sdl_value_little_endian(void) {
  const uint16_t value = 1;
  return ((const uint8_t *)&value)[0] == 1;
}

MOONBIT_FFI_EXPORT
void moonbit_sdl_value_write_bits(moonbit_bytes_t bytes, int32_t offset, int32_t size, uint64_t bits) {
  switch (size) {
    case 1: {
      uint8_t value = (uint8_t)bits;
      memcpy(bytes + offset, &value, sizeof(value));
      return;
    }
    case 2: {
      uint16_t value = (uint16_t)bits;
      memcpy(bytes + offset, &value, sizeof(value));
      return;
    }
    case 4: {
      uint32_t value = (uint32_t)bits;
      memcpy(bytes + offset, &value, sizeof(value));
      return;
    }
    case 8: {
      uint64_t value = (uint64_t)bits;
      memcpy(bytes + offset, &value, sizeof(value));
      return;
    }
    default: abort();
  }
}

moonbit_bytes_t moonbit_cstring_to_bytes_sdl(const char *str);

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_value_read_cstring(moonbit_bytes_t bytes, int32_t offset) {
  const char *value;
  memcpy(&value, bytes + offset, sizeof(value));
  return moonbit_cstring_to_bytes_sdl(value);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t moonbit_sdl_value_copy_bytes(moonbit_bytes_t bytes, int32_t offset, int32_t size) {
  moonbit_bytes_t result = moonbit_make_bytes(size, 0);
  memcpy(result, bytes + offset, size);
  return result;
}
