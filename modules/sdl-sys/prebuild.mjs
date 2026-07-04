#!/usr/bin/env node

import fs from 'node:fs'
import path from 'node:path'
import { loadEnvFile } from 'node:process'

const packageName = 'klaseca/sdl-sys'
const workspaceRoot = path.resolve(import.meta.dirname, '../..')
const defaultIncludeDir = path.join(workspaceRoot, 'externals', 'SDL', 'include')
const envFile = path.join(workspaceRoot, '.env')

if (fs.existsSync(envFile)) {
  loadEnvFile(envFile)
}

const toFlagPath = (file) => file.replaceAll(path.sep, '/')
const resolveConfigPath = (file) => path.resolve(workspaceRoot, file)

const includeDir = resolveConfigPath(process.env.SDL3_INCLUDE_DIR ?? defaultIncludeDir)
const libDir = process.env.SDL3_LIB_DIR ? resolveConfigPath(process.env.SDL3_LIB_DIR) : undefined

function fail(message) {
  console.error(`SDL prebuild: ${message}`)
  process.exit(1)
}

if (!fs.existsSync(path.join(includeDir, 'SDL3', 'SDL.h'))) {
  fail(`missing SDL headers. Set SDL3_INCLUDE_DIR or keep headers at ${defaultIncludeDir}`)
}

if (libDir == null) {
  fail(
    'missing SDL library directory. Set SDL3_LIB_DIR to the directory containing SDL3 library files',
  )
}

if (!fs.existsSync(libDir)) {
  fail(`SDL3_LIB_DIR does not exist: ${libDir}`)
}

process.stdout.write(
  JSON.stringify({
    vars: {
      SDL_STUB_CC_FLAGS: `-I${toFlagPath(includeDir)}`,
    },
    link_configs: [
      {
        package: packageName,
        link_flags: `-L${toFlagPath(libDir)}`,
        link_libs: ['SDL3'],
      },
    ],
  }),
)
