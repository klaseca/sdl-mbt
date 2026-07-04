///|
fn main {
  try! @sdl.App().run(setup)
}

///|
fn setup(app : @sdl.App) -> Unit raise @sdl.SdlError {
  let mut show_about = false
  let mut show_window = false

  let window = @sdl.Window(
    title="MoonBit SDL Tray",
    width=560,
    height=360,
    resizable=true,
    close_behavior=Hide,
  )
  defer window.destroy()

  let renderer = @sdl.Renderer(window)
  defer renderer.destroy()

  let tray = @sdl.Tray(
    tooltip="MoonBit SDL",
    menu=@sdl.Menu()
      .button(label="Show window", on_click=() => show_window = true)
      .button(label="About", on_click=() => show_about = true)
      .checkbox(label="Tray enabled", checked=true)
      .separator()
      .submenu(
        label="More",
        menu=@sdl.Menu().button(label="Quit", on_click=() => app.exit()),
      ),
  )
  defer tray.destroy()

  app.run_loop(() => {
    if show_window {
      show_window = false
      window.show()
      window.raise_window()
    }
    if show_about {
      show_about = false
      window.show_simple_message_box(
        title="MoonBit SDL",
        message="Tray callback is working.",
      )
    }
    renderer.set_draw_color(@sdl.Color::rgb(r=24, g=28, b=36))
    renderer.clear()
    renderer.present()
    @sdl.Tray::update()
  })
}
