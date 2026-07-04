# `klaseca/sdl`

High-level MoonBit bindings for SDL 3.

This module wraps `klaseca/sdl-sys` with a more MoonBit-friendly API for common
application code: initialization, windows, events, trays, renderers, textures,
clipboard, and message boxes.

The API is still young and may change while the binding grows.

## Installation

Add the module as a dependency from another MoonBit module:

```moonbit
import {
  "klaseca/sdl@0.0.1",
}
```

Native builds also need the SDL setup required by `klaseca/sdl-sys`: headers,
link library, and runtime DLL/shared library.

## Application Loop

`App` owns SDL initialization and shutdown for simple applications.

```mbt
fn main {
  try! @sdl.App().run(setup)
}

fn setup(app : @sdl.App) -> Unit raise @sdl.SdlError {
  let window = @sdl.Window(
    title="MoonBit SDL",
    width=800,
    height=480,
    resizable=true,
  )
  defer window.destroy()

  let renderer = @sdl.Renderer(window)
  defer renderer.destroy()

  app.run_loop(() => {
    renderer.set_draw_color(@sdl.Color::rgb(r=24, g=28, b=36))
    renderer.clear()
    renderer.present()
  })
}
```

`ControlFlow` controls how the loop waits between iterations:

- `Poll`: continue immediately.
- `Wait(Int)`: wait for an SDL event or timeout in milliseconds.
- `Exit`: stop the loop.

Call `app.exit()` from a callback or loop body to stop the loop.

## Windows

Create a window:

```mbt
let window = @sdl.Window(
  title="MoonBit SDL",
  width=800,
  height=480,
  resizable=true,
)
defer window.destroy()
```

Useful methods include:

- `show`, `hide`, `raise_window`, `minimize`, `maximize`, `restore`
- `size`, `size_in_pixels`, `position`, `title`, `flags`
- `set_title`, `set_size`, `set_position`, `set_placement`, `set_resizable`
- `set_fullscreen`, `set_bordered`, `set_always_on_top`
- `show_simple_message_box`

Use `WindowPlacement` for SDL-managed placement modes:

```mbt
window.set_placement(Centered)
window.set_placement(CenteredOnDisplay(1))
```

## Events

For low-level polling, use `poll_event()`:

```mbt
match @sdl.poll_event() {
  Some(Quit) => ()
  Some(WindowCloseRequested(event)) => println("close requested: \{event.window_id}")
  Some(_) | None => ()
}
```

`App` handles SDL `Quit` and window close requests in its run loop. Ordinary
windows close the application by default. Tray-style windows can opt into hiding
on close:

```mbt
let window = @sdl.Window(
  title="MoonBit SDL",
  width=800,
  height=480,
  close_behavior=Hide,
)
```

For window-specific event callbacks, use:

```mbt
let redraw = window.on(Exposed, _event => {
  renderer.clear()
  renderer.present()
})
defer redraw.dispose()
```

`WindowEvent` contains the `window_id`, the event `name`, and `size` for events
that carry window dimensions:

```mbt
let resized = window.on(Resized, event => {
  if event.size is Some(size) {
    println("window size: \{size.width}x\{size.height}")
  }
})
defer resized.dispose()
```

Currently supported window event names are:

- `Exposed`
- `Resized`
- `PixelSizeChanged`
- `CloseRequested`

## Rendering

Create a renderer from a window:

```mbt
let renderer = @sdl.Renderer(window)
defer renderer.destroy()

renderer.set_draw_color(@sdl.Color::rgb(r=70, g=155, b=255))
renderer.clear()
renderer.fill_rect(x=280.0, y=160.0, w=240.0, h=160.0)
renderer.present()
```

Textures are available through `Renderer::create_texture` or
`Texture::Texture`:

```mbt
let texture = renderer.create_texture(
  width=256,
  height=256,
  format=@sdl.Bgra8888,
  access=@sdl.Streaming,
)
defer texture.destroy()
```

Use `Texture::update` for direct pixel uploads.

## Tray

Tray menus are built declaratively with `Menu`:

```mbt
let tray = @sdl.Tray(
  tooltip="MoonBit SDL",
  menu=@sdl.Menu()
    .button(label="Show window", on_click=() => window.show())
    .button(label="About", on_click=() => {
      window.show_simple_message_box(
        title="MoonBit SDL",
        message="Hello from tray",
      )
    })
    .checkbox(label="Enabled", checked=true)
    .separator()
    .submenu(
      label="More",
      menu=@sdl.Menu().button(label="Quit", on_click=() => app.exit()),
    ),
)
defer tray.destroy()
```

If you use trays outside an SDL event-processing loop, call `Tray::update()`
periodically.

## Clipboard

```mbt
@sdl.Clipboard::set_text("Copied from MoonBit")
let text = @sdl.Clipboard::text()
```

## Error Handling

Most high-level operations that can fail raise `SdlError`.

```mbt
fn open_window() -> Unit raise @sdl.SdlError {
  let window = @sdl.Window(title="Example", width=640, height=480)
  defer window.destroy()
}
```

Use normal MoonBit error propagation in functions marked `raise`, or `try!`
from `main` for examples and experiments.
