///|
fn main {
  try! @sdl.App().run(setup)
}

///|
fn setup(app : @sdl.App) -> Unit raise @sdl.SdlError {
  let window = @sdl.Window(
    title="MoonBit SDL Texture",
    width=800,
    height=480,
    resizable=true,
  )
  defer window.destroy()

  let renderer = @sdl.Renderer(window)
  defer renderer.destroy()

  let texture = renderer.create_texture(
    width=2,
    height=2,
    format=Bgra8888,
    access=Static,
  )
  defer texture.destroy()

  let pixels : Bytes = [
    0xff, 0x40, 0x40, 0xff, 0x40, 0xff, 0x80, 0xff, 0xff, 0xb0, 0x40, 0xff, 0x40,
    0x80, 0xff, 0xff,
  ]
  texture.update(pixels~, pitch=8)

  app.run_loop(() => {
    renderer.set_draw_color(@sdl.Color::rgb(r=24, g=28, b=36))
    renderer.clear()
    renderer.render_texture(
      texture,
      dst=@sdl.FRect(x=280.0, y=120.0, w=240.0, h=240.0),
    )
    renderer.present()
  })
}
