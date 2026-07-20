// Generated file. Do not edit by hand.

#include <moonbit.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>

moonbit_bytes_t moonbit_cstring_to_bytes_sdl(const char *str) {
  if (str == NULL) {
    return moonbit_make_bytes(0, 0);
  }
  int32_t len = (int32_t)strlen(str);
  moonbit_bytes_t bytes = moonbit_make_bytes(len, 0);
  memcpy(bytes, str, len);
  return bytes;
}
