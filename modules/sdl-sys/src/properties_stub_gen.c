// Generated file. Do not edit by hand.

#include "../../../externals/SDL/include/SDL3/SDL.h"
#include <moonbit.h>
#include <stdint.h>

moonbit_bytes_t moonbit_cstring_to_bytes(const char *str);

SDL_PropertiesID moonbit_sdl_create_properties(void) {
  return SDL_CreateProperties();
}

int32_t moonbit_sdl_set_string_property(SDL_PropertiesID props, moonbit_bytes_t name, moonbit_bytes_t value) {
  return SDL_SetStringProperty(props, (const char *)name, (const char *)value);
}

int32_t moonbit_sdl_set_number_property(SDL_PropertiesID props, moonbit_bytes_t name, Sint64 value) {
  return SDL_SetNumberProperty(props, (const char *)name, value);
}

int32_t moonbit_sdl_set_float_property(SDL_PropertiesID props, moonbit_bytes_t name, float value) {
  return SDL_SetFloatProperty(props, (const char *)name, value);
}

int32_t moonbit_sdl_set_boolean_property(SDL_PropertiesID props, moonbit_bytes_t name, int32_t value) {
  return SDL_SetBooleanProperty(props, (const char *)name, value);
}

moonbit_bytes_t moonbit_sdl_get_string_property(SDL_PropertiesID props, moonbit_bytes_t name, moonbit_bytes_t default_value) {
  return moonbit_cstring_to_bytes(SDL_GetStringProperty(props, (const char *)name, (const char *)default_value));
}

Sint64 moonbit_sdl_get_number_property(SDL_PropertiesID props, moonbit_bytes_t name, Sint64 default_value) {
  return SDL_GetNumberProperty(props, (const char *)name, default_value);
}

float moonbit_sdl_get_float_property(SDL_PropertiesID props, moonbit_bytes_t name, float default_value) {
  return SDL_GetFloatProperty(props, (const char *)name, default_value);
}

int32_t moonbit_sdl_get_boolean_property(SDL_PropertiesID props, moonbit_bytes_t name, int32_t default_value) {
  return SDL_GetBooleanProperty(props, (const char *)name, default_value);
}

void moonbit_sdl_destroy_properties(SDL_PropertiesID props) {
  SDL_DestroyProperties(props);
}
