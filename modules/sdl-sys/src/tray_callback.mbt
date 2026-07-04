///|
pub type TrayEntryCallback

///|
#owned(callback)
pub extern "c" fn make_tray_entry_callback(
  call_callback : FuncRef[(() -> Unit) -> Unit],
  callback : () -> Unit,
) -> TrayEntryCallback = "moonbit_sdl_tray_entry_callback_make"

///|
#borrow(entry, callback)
pub extern "c" fn set_tray_entry_callback(
  entry : TrayEntry,
  callback : TrayEntryCallback,
) = "moonbit_sdl_set_tray_entry_callback"
