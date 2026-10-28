///|
pub type EventWatch

///|
pub fn Event::from_bytes(bytes : Bytes) -> Event {
  { bytes, offset: 0, }
}

///|
/// Register on the main thread after SDL events initialization. Main-thread
/// events invoke the callback immediately; other threads defer it until SDL's
/// main-thread event pump. The copied bytes own SDL text/drop/clipboard payloads;
/// user event data pointers retain the caller's ownership contract.
#owned(callback)
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
/// Remove on the main thread before SDL shutdown. Pending callbacks are cancelled;
/// repeated removal is harmless.
#borrow(watch)
pub extern "c" fn remove_event_watch(watch : EventWatch) = "moonbit_sdl_remove_event_watch"
