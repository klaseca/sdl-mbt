///|
test "renderer accepts an omitted driver and an explicit driver name" {
  with_event_window(window => {
    let expected = @sdl.Size::{ width: 160, height: 80, }
    let automatic_size = {
      let renderer = @sdl.Renderer(window)
      defer renderer.destroy()
      renderer.output_size()
    }
    assert_eq(automatic_size, expected)
    let renderer = @sdl.Renderer(window, name="software")
    defer renderer.destroy()
    assert_eq(renderer.output_size(), expected)
  })
}
