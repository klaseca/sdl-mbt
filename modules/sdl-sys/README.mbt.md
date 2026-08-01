# `klaseca/sdl-sys`

Low-level MoonBit bindings to the SDL 3 C API.

This module is the raw FFI layer used by `klaseca/sdl`. Most users should prefer
the high-level `klaseca/sdl` module unless they need direct access to generated
SDL functions, constants, opaque handles, or value structs.

The generated API follows the SDL C API closely. It intentionally does less
validation and owns fewer ergonomics than `klaseca/sdl`.

## Native Configuration

The module targets native builds and uses `--moonbit-unstable-prebuild` to emit
compiler options and semantic link configuration.

The prebuild script requires Node.js.

A shared SDL installation is discovered from the first successful source in
this order:

- an explicit `SDL3_INSTALL_PATH`;
- `pkg-config sdl3`;
- a vcpkg installed tree selected through `VCPKG_INSTALLED_DIR` or
  `VCPKG_ROOT`;
- prefixes listed in `CMAKE_PREFIX_PATH`;
- compiler include and library path environment variables.

`SDL3_INSTALL_PATH` is only needed for a development package installed outside
the standard discovery mechanisms. It must be an absolute path to an
installation containing matching headers and link libraries:

```text
SDL3_INSTALL_PATH/
├── include/
│   └── SDL3/
│       └── SDL.h
└── lib/
    └── SDL3 link library
```

On Windows, the current integration requires an MSVC-compatible ABI. Download
the `SDL3-devel-<version>-VC.zip` development archive and point
`SDL3_INSTALL_PATH` to the directory inside it that contains `include` and
`lib`.

When building SDL from source, create the same layout with CMake's install step:

```sh
cmake -S path/to/SDL -B path/to/SDL/build
cmake --build path/to/SDL/build --config Release
cmake --install path/to/SDL/build --config Release --prefix path/to/SDL/out
```

Then set `SDL3_INSTALL_PATH` to the absolute path of `path/to/SDL/out`.

The prebuild script emits the resolved library search directory and the
semantic `SDL3` library name on every platform. It does not choose
compiler-specific linker syntax; that translation belongs to MoonBit and the C
compiler configured by the package.

Set `MOON_NATIVE_RESOLVE_DEBUG=1` to print the detected target, every attempted
dependency source, and the reason rejected candidates were not used. Diagnostic
messages are written to standard error and do not affect the prebuild JSON.

The resolver uses the target information supplied by MoonBit when available.
Current MoonBit versions do not provide it to prebuild scripts, so native
dependency discovery falls back to the host operating system and architecture.
Cross-compilation therefore requires future MoonBit target metadata or an
explicit target when reusing the resolver directly.

`pkg-config` results are accepted only when their linker inputs can be expressed
as semantic library names and search paths. Unsupported options such as
framework or raw linker flags reject that discovery result instead of being
silently discarded. On Windows, use an MSVC-compatible vcpkg triplet such as
`x64-windows`. Set `VCPKG_TARGET_TRIPLET` when more than one compatible triplet
is installed or when the automatically selected triplet does not match the
configured compiler.

If linking SDL dynamically, the runtime library is not enough for linking but
must be available when the built executable starts. Use the platform's normal
loader mechanism: `PATH` or a DLL next to the executable on Windows,
`LD_LIBRARY_PATH`/rpath/system install on Linux, and
`DYLD_LIBRARY_PATH`/`@rpath`/application bundle packaging on macOS.

## API Conventions

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

SDL pointer resources are represented as opaque MoonBit types. Generated
constructors return resource handles backed by MoonBit external objects. Owned
handles have native finalizers, while APIs returning unmanaged SDL pointers are
configured explicitly. Generated destroy functions remain available for
deterministic cleanup with `defer`.

```mbt
let window = @sdl_sys.create_window(@utf8.encode("Example"), 640, 480, 0)
if window.is_null() {
  // Read @sdl_sys.get_error() or let the high-level module handle errors.
}
@sdl_sys.destroy_window(window)
```

The high-level `klaseca/sdl` module wraps these patterns with `SdlError` and
`destroy` methods.

## When To Use This Module

Use `klaseca/sdl-sys` when:

- a high-level wrapper does not exist yet;
- you need direct access to an SDL constant or raw handle;
- you are extending the high-level `klaseca/sdl` module.

For application code, prefer `klaseca/sdl`.
