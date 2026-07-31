// Generated file. Do not edit by hand.

///|
pub type Tray

///|
#borrow(resource)
extern "c" fn tray_is_null(resource : Tray) -> Bool = "moonbit_sdl_tray_is_null"

///|
pub fn Tray::is_null(self : Self) -> Bool {
  tray_is_null(self)
}

///|
#external
pub type TrayMenu

///|
pub fn TrayMenu::to_pointer(self : Self) -> Pointer = "%identity"

///|
pub fn TrayMenu::is_null(self : Self) -> Bool {
  self.to_pointer().is_null()
}

///|
#external
pub type TrayEntry

///|
pub fn TrayEntry::to_pointer(self : Self) -> Pointer = "%identity"

///|
pub fn TrayEntry::is_null(self : Self) -> Bool {
  self.to_pointer().is_null()
}

///|
pub const TRAYENTRY_BUTTON : UInt = 0x00000001

///|
pub const TRAYENTRY_CHECKBOX : UInt = 0x00000002

///|
pub const TRAYENTRY_SUBMENU : UInt = 0x00000004

///|
pub const TRAYENTRY_DISABLED : UInt = 0x80000000

///|
pub const TRAYENTRY_CHECKED : UInt = 0x40000000

///|
#borrow(tooltip)
pub extern "c" fn create_tray(tooltip : Bytes) -> Tray = "moonbit_sdl_create_tray"

///|
#borrow(tray, tooltip)
pub extern "c" fn set_tray_tooltip(tray : Tray, tooltip : Bytes) = "moonbit_sdl_set_tray_tooltip"

///|
#borrow(tray)
pub extern "c" fn create_tray_menu(tray : Tray) -> TrayMenu = "moonbit_sdl_create_tray_menu"

///|
pub extern "c" fn create_tray_submenu(entry : TrayEntry) -> TrayMenu = "moonbit_sdl_create_tray_submenu"

///|
#borrow(tray)
pub extern "c" fn get_tray_menu(tray : Tray) -> TrayMenu = "moonbit_sdl_get_tray_menu"

///|
pub extern "c" fn get_tray_submenu(entry : TrayEntry) -> TrayMenu = "moonbit_sdl_get_tray_submenu"

///|
pub extern "c" fn remove_tray_entry(entry : TrayEntry) = "moonbit_sdl_remove_tray_entry"

///|
#borrow(label)
pub extern "c" fn insert_tray_entry_at(menu : TrayMenu, pos : Int, label : Bytes, flags : UInt) -> TrayEntry = "moonbit_sdl_insert_tray_entry_at"

///|
#borrow(label)
pub extern "c" fn set_tray_entry_label(entry : TrayEntry, label : Bytes) = "moonbit_sdl_set_tray_entry_label"

///|
pub extern "c" fn get_tray_entry_label(entry : TrayEntry) -> Bytes = "moonbit_sdl_get_tray_entry_label"

///|
pub extern "c" fn set_tray_entry_checked(entry : TrayEntry, checked : Bool) = "moonbit_sdl_set_tray_entry_checked"

///|
pub extern "c" fn get_tray_entry_checked(entry : TrayEntry) -> Bool = "moonbit_sdl_get_tray_entry_checked"

///|
pub extern "c" fn set_tray_entry_enabled(entry : TrayEntry, enabled : Bool) = "moonbit_sdl_set_tray_entry_enabled"

///|
pub extern "c" fn get_tray_entry_enabled(entry : TrayEntry) -> Bool = "moonbit_sdl_get_tray_entry_enabled"

///|
pub extern "c" fn click_tray_entry(entry : TrayEntry) = "moonbit_sdl_click_tray_entry"

///|
#borrow(tray)
pub extern "c" fn destroy_tray(tray : Tray) = "moonbit_sdl_destroy_tray"

///|
pub extern "c" fn update_trays() = "moonbit_sdl_update_trays"
