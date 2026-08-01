#!/usr/bin/env node

import path from 'node:path'
import { nativeProvider, resolveNativeDependency } from './native-dependency.mjs'

const sdlInstallLayout = {
  includeDirectories: (installPath) => [path.join(installPath, 'include')],
  libraryDirectories: (installPath, layout) => {
    const baseDirs = [
      path.join(installPath, 'lib', layout.architecture),
      path.join(installPath, 'lib'),
    ]

    if (layout.platform === 'windows') {
      return [...baseDirs, path.join(installPath, layout.architecture), installPath]
    }

    return [...baseDirs, path.join(installPath, 'lib64')]
  },
}

const sdl = resolveNativeDependency({
  packageName: 'klaseca/sdl-sys',
  headers: ['SDL3/SDL.h'],
  providers: [
    nativeProvider.envInstallPath('SDL3_INSTALL_PATH', sdlInstallLayout),
    nativeProvider.pkgConfig('sdl3'),
    nativeProvider.vcpkg(sdlInstallLayout),
    nativeProvider.cmakePrefixPath(sdlInstallLayout),
    nativeProvider.toolchainSearchPaths,
  ],
  platformAliases: {
    win32: 'windows',
    darwin: 'macos',
  },
  architectureAliases: {
    ia32: 'x86',
    x86_64: 'x64',
    aarch64: 'arm64',
  },
  library: {
    linkName: 'SDL3',
    files: {
      windows: ['SDL3.lib'],
      macos: ['libSDL3.dylib'],
      android: ['libSDL3.so'],
      freebsd: ['libSDL3.so'],
      linux: ['libSDL3.so'],
      openbsd: ['libSDL3.so'],
    },
  },
})

const MOON_INCORRECT_LINK_FLAGS_WORKAROUND =
  process.platform === 'win32'
    ? {
        link_flags: '/link',
      }
    : {}

process.stdout.write(
  JSON.stringify({
    vars: {
      SDL_STUB_CC_FLAGS: sdl.compileFlags,
    },
    link_configs: [{ ...sdl.linkConfig, ...MOON_INCORRECT_LINK_FLAGS_WORKAROUND }],
  }),
)
