// Generated file. Do not edit by hand.

///|
pub const PROP_NAME_STRING : Bytes = b"SDL.name"

///|
pub extern "c" fn create_properties() -> UInt = "moonbit_sdl_create_properties"

///|
#borrow(name, value)
pub extern "c" fn set_string_property(props : UInt, name : Bytes, value : Bytes) -> Bool = "moonbit_sdl_set_string_property"

///|
#borrow(name)
pub extern "c" fn set_number_property(props : UInt, name : Bytes, value : Int64) -> Bool = "moonbit_sdl_set_number_property"

///|
#borrow(name)
pub extern "c" fn set_float_property(props : UInt, name : Bytes, value : Float) -> Bool = "moonbit_sdl_set_float_property"

///|
#borrow(name)
pub extern "c" fn set_boolean_property(props : UInt, name : Bytes, value : Bool) -> Bool = "moonbit_sdl_set_boolean_property"

///|
#borrow(name, default_value)
pub extern "c" fn get_string_property(props : UInt, name : Bytes, default_value : Bytes) -> Bytes = "moonbit_sdl_get_string_property"

///|
#borrow(name)
pub extern "c" fn get_number_property(props : UInt, name : Bytes, default_value : Int64) -> Int64 = "moonbit_sdl_get_number_property"

///|
#borrow(name)
pub extern "c" fn get_float_property(props : UInt, name : Bytes, default_value : Float) -> Float = "moonbit_sdl_get_float_property"

///|
#borrow(name)
pub extern "c" fn get_boolean_property(props : UInt, name : Bytes, default_value : Bool) -> Bool = "moonbit_sdl_get_boolean_property"

///|
pub extern "c" fn destroy_properties(props : UInt) = "moonbit_sdl_destroy_properties"
