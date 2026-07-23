#!/usr/bin/env node

import { basename } from 'node:path'
import { generateFiles, syncGeneratedFiles } from 'moonbit-bindgen'
import {
  createBindingEmitters,
  formatGenerationSummary,
  lowerBindings,
  loadBindingC,
  createSourceCRegex,
} from 'moonbit-bindgen/c'

import { sdlSysConfig } from './sdl_sys.config.ts'

const source = createSourceCRegex({
  prepareType: (type) =>
    type
      .replace(/\b(?:SDL_DECLSPEC|SDLCALL|SDL_PRINTF_FORMAT_STRING|SDL_MALLOC)\b/g, '')
      .replace(/\bSDL_(?:OUT_Z_CAP|INOUT_Z_CAP|OUT_CAP|INOUT_CAP)\([^)]*\)/g, ''),
  headerOutputBase: (file) => basename(file, '.h').replace(/^SDL_/, '').toLowerCase(),
  headerInclude: (file) => `<SDL3/${file}>`,
  functionPattern: /extern SDL_DECLSPEC (.*?) SDLCALL (SDL_\w+)\((.*?)\);/g,
  constantType: (name) => {
    if (name.endsWith('_ADAPTIVE')) return 'Int'
    return name.startsWith('SDL_WINDOW_') ? 'UInt64' : 'UInt'
  },
})

const { api, config, outputDir } = loadBindingC({
  bindingName: 'sdl',
  config: sdlSysConfig,
  source,
  baseDir: import.meta.dirname,
  namePrefixes: ['SDL_'],
  ownedCStringFree: 'SDL_free',
})
const binding = lowerBindings(api, config)
const files = generateFiles(binding, createBindingEmitters())
const result = syncGeneratedFiles({ outputDir, files })

console.log(formatGenerationSummary(binding, files))

if (result.changed.length > 0) {
  console.log(`updated: ${result.changed.join(', ')}`)
} else {
  console.log('generated files are unchanged')
}
