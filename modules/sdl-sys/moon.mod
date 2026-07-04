name = "klaseca/sdl-sys"

version = "0.0.0"

readme = "README.mbt.md"

repository = "https://github.com/klaseca/sdl-mbt"

license = "Apache-2.0"

keywords = ["sdl"]

description = "Low-level MoonBit bindings for SDL C API"

preferred_target = "native"

options(
  source: "src",
  "--moonbit-unstable-prebuild": "prebuild.mjs",
)
