///|
pub(all) suberror SdlError {
  SdlError(String)
} derive(Debug, Eq)

///|
fn raise_last_error(context : String) -> Unit raise SdlError {
  let message = @utf8.decode_lossy(@sys.get_error())
  if message == "" {
    raise SdlError("\{context} failed")
  } else {
    raise SdlError("\{context} failed: \{message}")
  }
}

///|
fn check_ok(ok : Bool, context : String) -> Unit raise SdlError {
  if !ok {
    raise_last_error(context)
  }
}
