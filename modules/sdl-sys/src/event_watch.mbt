///|
pub type EventWatch

///|
pub fn Event::from_bytes(bytes : Bytes) -> Event {
  { bytes, }
}

///|
pub extern "c" fn add_event_watch(
  call_callback : FuncRef[((Bytes) -> Unit, Bytes) -> Unit],
  callback : (Bytes) -> Unit,
) -> EventWatch = "moonbit_sdl_add_event_watch"

///|
#borrow(watch)
extern "c" fn event_watch_is_null(watch : EventWatch) -> Bool = "moonbit_sdl_event_watch_is_null"

///|
pub fn EventWatch::is_null(self : Self) -> Bool {
  event_watch_is_null(self)
}

///|
#borrow(watch)
pub extern "c" fn remove_event_watch(watch : EventWatch) = "moonbit_sdl_remove_event_watch"
