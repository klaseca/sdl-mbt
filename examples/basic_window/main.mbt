///|
fn main {
  try! @sdl.App().run(setup)
}

///|
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

  let background = @sdl.Color::rgb(r=24, g=28, b=36)
  let accent = @sdl.Color::rgb(r=70, g=155, b=255)

  app.run_loop(() => {
    renderer.set_draw_color(background)
    renderer.clear()
    renderer.set_draw_color(accent)
    renderer.fill_rect(x=280.0, y=160.0, w=240.0, h=160.0)
    renderer.present()
  })
}
