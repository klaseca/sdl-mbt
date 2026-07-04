# `klaseca/sdl-sys`

Low-level MoonBit bindings to the SDL 3 C API.

This module is the raw FFI layer used by `klaseca/sdl`. Most users should prefer
the high-level `klaseca/sdl` module unless they need direct access to generated
SDL functions, constants, opaque handles, or value structs.

## Scope

`sdl-sys` provides:

- generated SDL constants;
- generated `extern "c"` declarations and C stubs;
- opaque SDL resource handles such as `Window`, `Renderer`, `Texture`, `Tray`;
- small value structs backed by bytes, such as `Rect`, `FRect`, and `Event`;
- manual support code for callbacks and texture locking where needed.

The generated API follows the SDL C API closely. It intentionally does less
validation and owns fewer ergonomics than `klaseca/sdl`.

## Native Configuration

The module targets native builds and uses `--moonbit-unstable-prebuild` to emit
compiler and linker flags.

Configuration is read from the repository `.env` file:

```text
SDL3_LIB_DIR=references/SDL3
# SDL3_INCLUDE_DIR=externals/SDL/include
```

`SDL3_INCLUDE_DIR` defaults to `externals/SDL/include`.

`SDL3_LIB_DIR` is required and must point to the directory containing the SDL
link library. On Windows this is the directory containing the SDL import
library used with `-lSDL3`; on Unix-like systems this is the directory
containing the SDL shared or static library used by the linker.

If linking SDL dynamically, the runtime library is not enough for linking but
must be available when the built executable starts. Use the platform's normal
loader mechanism: `PATH` or a DLL next to the executable on Windows,
`LD_LIBRARY_PATH`/rpath/system install on Linux, and
`DYLD_LIBRARY_PATH`/`@rpath`/application bundle packaging on macOS.

## Generator

Run the generator from the repository root:

```sh
node modules/sdl-sys/codegen/codegen_sdl_sys.mjs
```

The generator configuration is:

```text
modules/sdl-sys/codegen/sdl_sys.config.json
```

Important configuration sections:

- `headers`: SDL headers scanned by the generator.
- `functions`: SDL functions to expose.
- `valueStructs`: SDL structs represented as MoonBit byte-backed values.
- `resources`: SDL pointer resources with destroy functions.
- `renames`: generated name overrides.
- `constantPrefixes`: SDL constant groups to emit.

Generated files use the `_gen` suffix, for example `events_gen.mbt` and
`events_stub_gen.c`.

## Naming

Generated MoonBit names are lower snake case and remove the SDL prefix:

```text
SDL_CreateWindow -> create_window
SDL_DestroyWindow -> destroy_window
SDL_PollEvent -> poll_event
```

C stub symbols keep the `moonbit_sdl_` prefix:

```text
moonbit_sdl_create_window
moonbit_sdl_poll_event_ffi
```

Extern declarations in MoonBit refer to those C symbols directly.

## Value Structs

SDL value structs are represented as byte-backed MoonBit structs. For example:

```mbt
let rect = @sdl_sys.Rect(0, 0, 640, 480)
let raw = rect.to_bytes()
```

`Event` is also byte-backed and exposes generated field accessors:

```mbt
let event = @sdl_sys.Event()
if @sdl_sys.poll_event(event) {
  let event_type = event.event_type()
}
```

## Resource Handles

SDL pointer resources are represented as opaque MoonBit types. Generated
constructors return resource handles and generated destroy functions release
them.

```mbt
let window = @sdl_sys.create_window(@utf8.encode("Example"), 640, 480, 0)
if window.is_null() {
  // Read @sdl_sys.get_error() or let the high-level module handle errors.
}
@sdl_sys.destroy_window(window)
```

The high-level `klaseca/sdl` module wraps these patterns with `SdlError` and
`destroy` methods.

## Manual Support Files

Some bindings are still implemented manually beside generated files when the C
API shape needs custom glue:

- callback trampolines;
- texture lock helpers;
- common pointer helpers;
- C string conversion helpers.

These files live in `modules/sdl-sys/src` without the `_gen` suffix.

## When To Use This Module

Use `klaseca/sdl-sys` when:

- a high-level wrapper does not exist yet;
- you need direct access to an SDL constant or raw handle;
- you are extending the high-level `klaseca/sdl` module;
- you are improving the generator.

For application code, prefer `klaseca/sdl`.
