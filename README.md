# SDL bindings for MoonBit

This repository contains MoonBit bindings for SDL 3. It is organized as a
workspace with two publishable modules:

- `klaseca/sdl-sys`: generated low-level bindings to the SDL C API.
- `klaseca/sdl`: a higher-level MoonBit API built on top of `sdl-sys`.

The bindings currently target native builds. The public API is still evolving;
the project is intended to grow from the window, event, tray, renderer, and
texture APIs that are already present.

## Requirements

- Node.js, used by the prebuild script and binding generator. The supported
  version is defined in `package.json`.
- A shared SDL 3 development package containing matching headers and link
  libraries.
- If linking SDL dynamically, the SDL runtime library must be discoverable by
  the operating system loader when the built application starts.

The prebuild script first honors `SDL3_INSTALL_PATH`, then tries `pkg-config`,
vcpkg, prefixes from `CMAKE_PREFIX_PATH`, and the include and library path
environment variables used by compilers.

Install SDL through the platform's package manager when possible. For a
manually unpacked SDK, set `SDL3_INSTALL_PATH` to the absolute installation
path containing `include/SDL3/SDL.h` and the `lib` directory:

On Windows, the current integration requires an MSVC-compatible ABI. Download
the `SDL3-devel-<version>-VC.zip` development archive.

```sh
SDL3_INSTALL_PATH=/opt/SDL3 moon run examples/basic_window
```

In PowerShell:

```powershell
$env:SDL3_INSTALL_PATH = "C:\Libraries\SDL3"
moon run examples/basic_window
```

For local development, build and install the SDL submodule into a prefix:

```sh
cmake -S externals/SDL -B externals/SDL/build
cmake --build externals/SDL/build --config Release
cmake --install externals/SDL/build --config Release --prefix externals/SDL/out
```

Set `SDL3_INSTALL_PATH` to the absolute path of `externals/SDL/out`. Relative
paths are rejected. This uses the same `include`/`lib` layout as any other
manually installed SDL development package.

If automatic discovery fails, set `MOON_NATIVE_RESOLVE_DEBUG=1` before running
`moon` to print every attempted dependency source and its rejection reason to
standard error.

Current MoonBit prebuild input does not expose the compilation target, so
automatic discovery uses the host operating system and architecture. It is
intended for native host builds; cross-compilation needs target metadata from
MoonBit. Set `VCPKG_TARGET_TRIPLET` when vcpkg contains multiple compatible
triplets or its automatic choice does not match the configured compiler.

Clone the SDL submodule and install the generator dependency only when
developing or regenerating the bindings:

```sh
git submodule update --init --recursive
npm install
```

## Runtime Shared Library

Native dependency discovery configures compiler options, link libraries, and
library search paths only. It does not install or copy SDL's runtime library.

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

## Binding Generation

The low-level `sdl-sys` module is generated from the SDL headers. See the
[binding generation guide](bindgen/README.md) when updating SDL declarations or
the SDL-specific binding policy.

## Documentation

Module documentation:

- [`klaseca/sdl`](modules/sdl/README.mbt.md)
- [`klaseca/sdl-sys`](modules/sdl-sys/README.mbt.md)
