///|
pub(all) struct Properties {
  raw : UInt
}

///|
pub(all) enum Property {
  StringProperty(name~ : Bytes, value~ : String)
  NumberProperty(name~ : Bytes, value~ : Int64)
  FloatProperty(name~ : Bytes, value~ : Float)
  BooleanProperty(name~ : Bytes, value~ : Bool)
} derive(Debug, Eq)

///|
pub fn Properties::Properties() -> Self raise SdlError {
  let raw = @sys.create_properties()
  if raw == 0 {
    raise_last_error("SDL_CreateProperties")
  }
  { raw, }
}

///|
pub fn Properties::destroy(self : Self) -> Unit {
  if self.raw != 0 {
    @sys.destroy_properties(self.raw)
  }
}

///|
pub fn Properties::set_string(
  self : Self,
  name~ : Bytes,
  value~ : String?,
) -> Unit raise SdlError {
  if value is Some(value) {
    check_ok(
      @sys.set_string_property(self.raw, name, @utf8.encode(value)),
      "SDL_SetStringProperty",
    )
  }
}

///|
fn Properties::set_number(
  self : Self,
  name~ : Bytes,
  value~ : Int64?,
) -> Unit raise SdlError {
  if value is Some(value) {
    check_ok(
      @sys.set_number_property(self.raw, name, value),
      "SDL_SetNumberProperty",
    )
  }
}

///|
fn Properties::set_float(
  self : Self,
  name~ : Bytes,
  value~ : Float?,
) -> Unit raise SdlError {
  if value is Some(value) {
    check_ok(
      @sys.set_float_property(self.raw, name, value),
      "SDL_SetFloatProperty",
    )
  }
}

///|
pub fn Properties::set_boolean(
  self : Self,
  name~ : Bytes,
  value~ : Bool?,
) -> Unit raise SdlError {
  if value is Some(value) {
    check_ok(
      @sys.set_boolean_property(self.raw, name, value),
      "SDL_SetBooleanProperty",
    )
  }
}

///|
pub fn Properties::set_property(
  self : Self,
  property : Property,
) -> Unit raise SdlError {
  match property {
    StringProperty(name~, value~) => self.set_string(name~, value=Some(value))
    NumberProperty(name~, value~) => self.set_number(name~, value=Some(value))
    FloatProperty(name~, value~) => self.set_float(name~, value=Some(value))
    BooleanProperty(name~, value~) => self.set_boolean(name~, value=Some(value))
  }
}

///|
pub fn Properties::raw(self : Self) -> UInt {
  self.raw
}
