// Generated file. Do not edit by hand.

///|
pub const INIT_AUDIO : UInt = 0x00000010

///|
pub const INIT_CAMERA : UInt = 0x00010000

///|
pub const INIT_EVENTS : UInt = 0x00004000

///|
pub const INIT_GAMEPAD : UInt = 0x00002000

///|
pub const INIT_HAPTIC : UInt = 0x00001000

///|
pub const INIT_JOYSTICK : UInt = 0x00000200

///|
pub const INIT_SENSOR : UInt = 0x00008000

///|
pub const INIT_VIDEO : UInt = 0x00000020

///|
pub const PROP_APP_METADATA_COPYRIGHT_STRING : Bytes = b"SDL.app.metadata.copyright"

///|
pub const PROP_APP_METADATA_CREATOR_STRING : Bytes = b"SDL.app.metadata.creator"

///|
pub const PROP_APP_METADATA_IDENTIFIER_STRING : Bytes = b"SDL.app.metadata.identifier"

///|
pub const PROP_APP_METADATA_NAME_STRING : Bytes = b"SDL.app.metadata.name"

///|
pub const PROP_APP_METADATA_TYPE_STRING : Bytes = b"SDL.app.metadata.type"

///|
pub const PROP_APP_METADATA_URL_STRING : Bytes = b"SDL.app.metadata.url"

///|
pub const PROP_APP_METADATA_VERSION_STRING : Bytes = b"SDL.app.metadata.version"

///|
pub extern "c" fn init_lib(flags : UInt) -> Bool = "moonbit_sdl_init"

///|
pub extern "c" fn quit() = "moonbit_sdl_quit"
