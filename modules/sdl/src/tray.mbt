///|
pub using @sys {
  TRAYENTRY_BUTTON,
  TRAYENTRY_CHECKBOX,
  TRAYENTRY_SUBMENU,
  TRAYENTRY_DISABLED,
  TRAYENTRY_CHECKED,
}

///|
let call_tray_callback : FuncRef[(() -> Unit) -> Unit] = fn(callback) {
  callback()
}

///|
priv trait MenuElement {
  fn insert(Self, TrayMenu, Int) -> Unit raise SdlError
}

///|
pub struct Menu {
  priv elements : Array[&MenuElement]
}

///|
pub fn Menu::Menu() -> Self {
  { elements: [] }
}

///|
pub fn Menu::button(
  self : Self,
  label~ : String,
  on_click? : () -> Unit,
  enabled? : Bool = true,
) -> Self {
  let mut flags = TRAYENTRY_BUTTON
  if !enabled {
    flags = flags + TRAYENTRY_DISABLED
  }
  self.elements.push(Button::{ label, flags, on_click })
  self
}

///|
pub fn Menu::checkbox(
  self : Self,
  label~ : String,
  on_click? : () -> Unit,
  checked? : Bool = false,
  enabled? : Bool = true,
) -> Self {
  let mut flags = TRAYENTRY_CHECKBOX
  if checked {
    flags = flags + TRAYENTRY_CHECKED
  }
  if !enabled {
    flags = flags + TRAYENTRY_DISABLED
  }
  self.elements.push(Checkbox::{ label, flags, on_click })
  self
}

///|
pub fn Menu::separator(self : Self) -> Self {
  self.elements.push(Separator::{  })
  self
}

///|
pub fn Menu::submenu(self : Self, label~ : String, menu~ : Menu) -> Self {
  self.elements.push(Submenu::{ label, menu })
  self
}

///|
pub fn Menu::extend(self : Self, menu : Menu) -> Self {
  self.elements.append(menu.elements)
  self
}

///|
priv struct Button {
  label : String
  flags : UInt
  on_click : (() -> Unit)?
}

///|
impl MenuElement for Button with fn insert(self, menu, pos) {
  let element = menu.insert_entry(@utf8.encode(self.label), self.flags, pos~)
  element.set_on_click(self.on_click)
}

///|
priv struct Checkbox {
  label : String
  flags : UInt
  on_click : (() -> Unit)?
}

///|
impl MenuElement for Checkbox with fn insert(self, menu, pos) {
  let element = menu.insert_entry(@utf8.encode(self.label), self.flags, pos~)
  element.set_on_click(self.on_click)
}

///|
priv struct Separator {}

///|
impl MenuElement for Separator with fn insert(_self, menu, pos) {
  menu.insert_entry([], 0, pos~) |> ignore
}

///|
priv struct Submenu {
  label : String
  menu : Menu
}

///|
impl MenuElement for Submenu with fn insert(self, menu, pos) {
  let entry = menu.insert_entry(
    @utf8.encode(self.label),
    TRAYENTRY_SUBMENU,
    pos~,
  )
  entry.submenu().extend(self.menu)
}

///|
priv struct TrayContext {
  callback_handles : Array[@sys.TrayEntryCallback]
}

///|
struct Tray {
  raw : @sys.Tray
  context : TrayContext
}

///|
pub fn Tray::Tray(tooltip~ : String, menu? : Menu) -> Tray raise SdlError {
  let raw = @sys.create_tray(@utf8.encode(tooltip))
  if raw.is_null() {
    raise_last_error("SDL_CreateTray")
  }
  let tray : Tray = { raw, context: { callback_handles: [] } }
  if menu is Some(menu) {
    tray.extend(menu)
  }
  tray
}

///|
pub fn Tray::destroy(self : Self) -> Unit {
  @sys.destroy_tray(self.raw)
}

///|
pub fn Tray::set_tooltip(self : Self, tooltip : String) -> Unit {
  @sys.set_tray_tooltip(self.raw, @utf8.encode(tooltip))
}

///|
pub fn Tray::extend(self : Self, menu : Menu) -> Unit raise SdlError {
  self.menu().extend(menu)
}

///|
fn Tray::menu(self : Self) -> TrayMenu raise SdlError {
  let existing = @sys.get_tray_menu(self.raw)
  if !existing.is_null() {
    return { raw: existing, context: self.context }
  }
  let raw = @sys.create_tray_menu(self.raw)
  if raw.is_null() {
    raise_last_error("SDL_CreateTrayMenu")
  }
  { raw, context: self.context }
}

///|
pub fn Tray::raw(self : Self) -> @sys.Tray {
  self.raw
}

///|
priv struct TrayMenu {
  raw : @sys.TrayMenu
  context : TrayContext
}

///|
fn TrayMenu::insert_menu(
  self : Self,
  menu : Menu,
  pos? : Int = -1,
) -> Unit raise SdlError {
  for i, element in menu.elements {
    let element_pos = if pos < 0 { -1 } else { pos + i }
    element.insert(self, element_pos)
  }
}

///|
fn TrayMenu::insert_entry(
  self : Self,
  label : Bytes,
  flags : UInt,
  pos? : Int = -1,
) -> TrayEntry raise SdlError {
  let raw = @sys.insert_tray_entry_at(self.raw, pos, label, flags)
  if raw.is_null() {
    raise_last_error("SDL_InsertTrayEntryAt")
  }
  { raw, context: self.context }
}

///|
fn TrayMenu::extend(self : Self, menu : Menu) -> Unit raise SdlError {
  self.insert_menu(menu)
}

///|
priv struct TrayEntry {
  raw : @sys.TrayEntry
  context : TrayContext
}

///|
fn TrayEntry::set_on_click(self : Self, callback : (() -> Unit)?) -> Unit {
  if callback is Some(callback) {
    let handle = @sys.make_tray_entry_callback(call_tray_callback, callback)
    self.context.callback_handles.push(handle)
    @sys.set_tray_entry_callback(self.raw, handle)
  }
}

///|
fn TrayEntry::submenu(self : Self) -> TrayMenu raise SdlError {
  let existing = @sys.get_tray_submenu(self.raw)
  if !existing.is_null() {
    return { raw: existing, context: self.context }
  }
  let raw = @sys.create_tray_submenu(self.raw)
  if raw.is_null() {
    raise_last_error("SDL_CreateTraySubmenu")
  }
  { raw, context: self.context }
}

///|
pub fn Tray::update() -> Unit {
  @sys.update_trays()
}
