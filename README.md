# SDL bindings for MoonBit

This repository contains MoonBit bindings for SDL 3. It is organized as a
workspace with two publishable modules:

- `klaseca/sdl-sys`: generated low-level bindings to the SDL C API.
- `klaseca/sdl`: a higher-level MoonBit API built on top of `sdl-sys`.

The bindings currently target native builds. The public API is still evolving;
the project is intended to grow from the window, event, tray, renderer, and
texture APIs that are already present.

## Repository Layout

```text
examples/
  basic_window/         Minimal window and renderer example.
  texture/              Texture upload/rendering example.
  tray/                 Tray menu example.
modules/
  sdl/                  High-level MoonBit API.
  sdl-sys/              Generated C FFI layer and generator.
externals/SDL/          SDL headers used by the generated stubs.
```

## Requirements

- MoonBit with native backend support.
- Node.js, used by the `sdl-sys` generator and prebuild script.
- SDL 3 headers and native libraries.
- If linking SDL dynamically, the SDL runtime library must be discoverable by
  the operating system loader when the built application starts.

The default setup expects SDL headers in `externals/SDL/include` and reads link
configuration from `.env`.

`SDL3_LIB_DIR` should point to the directory containing the SDL import library
used by the linker. `SDL3_INCLUDE_DIR` is optional when the SDL headers are kept
in `externals/SDL/include`.

## Runtime Shared Library

The `.env` file configures compile and link flags only. It does not install or
copy SDL's runtime library.

For applications linked against the shared SDL library, make sure the runtime
library is discoverable before running the executable:

- Windows: expose `SDL3.dll` through `PATH`, copy it next to the executable in
  your packaging step, or use a system/package-manager installation.
- Linux: install SDL system-wide, configure an rpath in your application build,
  or expose the directory containing `libSDL3.so` through `LD_LIBRARY_PATH`.
- macOS: install SDL system-wide, package `libSDL3.dylib` with the application
  and configure `@rpath`, or expose it through `DYLD_LIBRARY_PATH` for local
  development.

## Building

Run an example:

```sh
moon run examples/basic_window
moon run examples/texture
moon run examples/tray
```

Run checks:

```sh
moon check
moon test
```

Regenerate package interfaces after public API changes:

```sh
moon info
```

Format MoonBit files:

```sh
moon fmt
```

## Code Generation

The low-level `sdl-sys` bindings are generated from SDL headers by:

```sh
node modules/sdl-sys/codegen/codegen_sdl_sys.mjs
```

The generator configuration lives in:

```text
modules/sdl-sys/codegen/sdl_sys.config.json
```

Generated MoonBit and C files use the `_gen` suffix. Manual support files are
kept beside them in `modules/sdl-sys/src`.

## Documentation

Module documentation lives in each module
