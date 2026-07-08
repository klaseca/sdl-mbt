#!/usr/bin/env node

import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const toolDir = import.meta.dirname
const configPath = process.argv[2]
  ? path.resolve(process.cwd(), process.argv[2])
  : path.join(toolDir, 'sdl_sys.config.json')
const config = JSON.parse(fs.readFileSync(configPath, 'utf8'))

const projectRoot = path.resolve(toolDir, config.projectRoot)
const includeDir = path.resolve(projectRoot, config.includeDir)
const outDir = path.resolve(projectRoot, config.outputDir)
const includeFiles = config.headers
const functionConfigs = (config.functions ?? []).map(normalizeFunctionConfig)
const namedFunctionConfigs = functionConfigs.filter((fn) => typeof fn.name === 'string')
const functionAllowList = new Set(namedFunctionConfigs.map((fn) => fn.name))
const functionConfigByName = new Map(namedFunctionConfigs.map((fn) => [fn.name, fn]))
const functionRenames = new Map(Object.entries(config.renames?.functions ?? {}))
const constantPrefixes = config.constantPrefixes
const configuredValueStructs = new Map(Object.entries(config.valueStructs ?? {}))
const configuredResources = new Map(Object.entries(config.resources ?? {}))

const AbiKind = Object.freeze({
  BytesParam: 'bytes-param',
  CStringReturn: 'cstring-return',
  Direct: 'direct',
  FloatOutParam: 'float-out-param',
  ImplicitNullParam: 'implicit-null-param',
  IntOutParam: 'int-out-param',
  NullableValueStructParam: 'nullable-value-struct-param',
  OpaquePointer: 'opaque-pointer',
  OwnedCStringReturn: 'owned-cstring-return',
  PointerOutParam: 'pointer-out-param',
  ResourcePointer: 'resource-pointer',
  ValueStructParam: 'value-struct-param',
  VoidBytesParam: 'void-bytes-param',
})

function getGenLines() {
  return [`// Generated file. Do not edit by hand.`, '']
}

function abi(kind, fields = {}) {
  return { ...fields, kind }
}

function mappedType({ mbt, c, cType, kind = AbiKind.Direct, ...abiFields }) {
  return { mbt, c, cType, abi: abi(kind, abiFields) }
}

function normalizeFunctionConfig(entry) {
  if (typeof entry === 'string') return { name: entry, params: {}, return: {} }
  if (entry && typeof entry === 'object' && !Array.isArray(entry)) {
    return {
      name: entry.name,
      params: entry.params ?? {},
      return: entry.return ?? {},
    }
  }
  return { name: undefined, params: {} }
}

function configuredReturn(cName) {
  const value = functionConfigByName.get(cName)?.return
  return value && typeof value === 'object' && !Array.isArray(value) ? value : {}
}

function configuredParam(cName, paramName) {
  const params = functionConfigByName.get(cName)?.params
  if (!params || typeof params !== 'object' || Array.isArray(params)) return {}
  const value = params[paramName]
  return value && typeof value === 'object' && !Array.isArray(value) ? value : {}
}

const primitiveMbtTypes = new Map([
  ['bool', 'Bool'],
  ['char', 'Byte'],
  ['double', 'Double'],
  ['float', 'Float'],
  ['int', 'Int'],
  ['Sint64', 'Int64'],
  ['Sint32', 'Int'],
  ['Uint8', 'Byte'],
  ['Uint16', 'UInt16'],
  ['Uint32', 'UInt'],
  ['Uint64', 'UInt64'],
  ['void', 'Unit'],
])

const aliasMbtTypes = new Map([
  ['SDL_EventType', 'UInt'],
  ['SDL_BlendMode', 'UInt'],
  ['SDL_InitFlags', 'UInt'],
  ['SDL_Keycode', 'UInt'],
  ['SDL_KeyboardID', 'UInt'],
  ['SDL_Keymod', 'UInt16'],
  ['SDL_MessageBoxFlags', 'UInt'],
  ['SDL_MouseButtonFlags', 'UInt'],
  ['SDL_MouseID', 'UInt'],
  ['SDL_PixelFormat', 'UInt'],
  ['SDL_PropertiesID', 'UInt'],
  ['SDL_Scancode', 'Int'],
  ['SDL_TextureAccess', 'UInt'],
  ['SDL_TrayEntryFlags', 'UInt'],
  ['SDL_WindowID', 'UInt'],
  ['SDL_WindowFlags', 'UInt64'],
])

function readHeaders() {
  return includeFiles.map((file) => {
    const source = fs.readFileSync(path.join(includeDir, file), 'utf8')
    return {
      file,
      base: headerOutputBase(file),
      source,
      stripped: stripComments(source),
    }
  })
}

function stripComments(source) {
  return source.replace(/\/\*[\s\S]*?\*\//g, ' ').replace(/\/\/.*$/gm, ' ')
}

function toSnake(name) {
  return name
    .replace(/^SDL_/, '')
    .replace(/([A-Z]+)([A-Z][a-z])/g, '$1_$2')
    .replace(/([a-z0-9])([A-Z])/g, '$1_$2')
    .toLowerCase()
}

function toMoonbitConst(name) {
  return name.replace(/^SDL_/, '')
}

function normalizeType(type) {
  return type
    .replace(/\bSDL_DECLSPEC\b/g, '')
    .replace(/\bSDLCALL\b/g, '')
    .replace(/\bconst\b/g, 'const')
    .replace(/\s+/g, ' ')
    .replace(/\s+\*/g, ' *')
    .trim()
}

function mapType({ type, position, opaqueTypes = new Map(), valueStructs = new Map() }) {
  const normalized = normalizeType(type)
  if (normalized === 'const char *') {
    return position === 'return'
      ? mappedType({ mbt: 'Bytes', c: 'moonbit_bytes_t', kind: AbiKind.CStringReturn })
      : mappedType({ mbt: 'Bytes', c: 'moonbit_bytes_t', kind: AbiKind.BytesParam })
  }
  if (position === 'param' && normalized === 'const void *') {
    return mappedType({ mbt: 'Bytes', c: 'moonbit_bytes_t', kind: AbiKind.VoidBytesParam })
  }
  if (position === 'return' && normalized === 'char *') {
    return mappedType({ mbt: 'Bytes', c: 'moonbit_bytes_t', kind: AbiKind.OwnedCStringReturn })
  }
  if (position === 'param' && normalized === 'void **') {
    return mappedType({
      mbt: 'Ref[Pointer]',
      c: 'void **',
      cType: 'void *',
      kind: AbiKind.PointerOutParam,
    })
  }
  if (position === 'param' && normalized === 'int *') {
    return mappedType({ mbt: 'Ref[Int]', c: 'int32_t *', cType: 'int', kind: AbiKind.IntOutParam })
  }
  if (position === 'param' && normalized === 'float *') {
    return mappedType({
      mbt: 'Ref[Float]',
      c: 'float *',
      cType: 'float',
      kind: AbiKind.FloatOutParam,
    })
  }
  const mbt = primitiveMbtTypes.get(normalized) ?? aliasMbtTypes.get(normalized)
  if (mbt) {
    return mappedType({ mbt, c: normalized === 'bool' ? 'int32_t' : normalized, cType: normalized })
  }
  const pointerMatch = normalized.match(/^(const\s+)?(SDL_\w+)\s*\*$/)
  if (pointerMatch && valueStructs.has(pointerMatch[2])) {
    const valueStruct = valueStructs.get(pointerMatch[2])
    return mappedType({
      mbt: valueStruct.mbtName,
      c: 'moonbit_bytes_t',
      cType: valueStruct.cName,
      kind: AbiKind.ValueStructParam,
      isConst: Boolean(pointerMatch[1]),
    })
  }
  if (pointerMatch && opaqueTypes.has(pointerMatch[2])) {
    const cType = pointerMatch[2]
    if (configuredResources.has(cType)) {
      return mappedType({
        mbt: opaqueTypes.get(cType),
        c: `${resourceStructName(cType)} *`,
        cType,
        kind: AbiKind.ResourcePointer,
      })
    }
    return mappedType({
      mbt: opaqueTypes.get(cType),
      c: `${cType} *`,
      cType,
      kind: AbiKind.OpaquePointer,
    })
  }
  return undefined
}

function typeNameFromOpaque(cName) {
  return cName.replace(/^SDL_/, '')
}

function valueStructMakeName(mbtName) {
  return toSnake(`SDL_${mbtName}`)
}

function resourceBaseName(cName) {
  return toSnake(cName)
}

function resourceStructName(cName) {
  return `moonbit_sdl_${resourceBaseName(cName)}_resource_t`
}

function resourceHelperPrefix(cName) {
  return `moonbit_sdl_${resourceBaseName(cName)}`
}

function moonbitFunctionName(cName, rawName) {
  return functionRenames.get(cName) ?? rawName
}

function cStubSymbol(rawName) {
  return `moonbit_sdl_${rawName}`
}

function headerOutputBase(file) {
  return path.basename(file, '.h').replace(/^SDL_/, '').toLowerCase()
}

function parseOpaqueTypes(source) {
  const types = new Map()
  for (const match of source.matchAll(/typedef\s+struct\s+(SDL_\w+)\s+\1\s*;/g)) {
    types.set(match[1], typeNameFromOpaque(match[1]))
  }
  return types
}

function parseFieldDeclarations(body) {
  const fields = []
  for (const statement of body.split(';')) {
    const text = statement.trim()
    if (!text) continue
    const parsed = parseFieldStatement(text)
    if (!parsed) continue
    for (const rawName of parsed.declarators) {
      const declarator = parseFieldDeclarator(parsed.baseType, rawName)
      if (!declarator) continue
      const mapped = mapType({ type: declarator.cType, position: 'field' })
      if (!mapped || mapped.mbt === 'Unit') continue
      const { name, cType } = declarator
      if (!/^[A-Za-z_]\w*$/.test(name)) continue
      fields.push({ name, cType, mbt: mapped.mbt, c: mapped.c })
    }
  }
  return fields
}

function parseFieldStatement(text) {
  const parts = text
    .split(',')
    .map((part) => part.trim())
    .filter(Boolean)
  if (parts.length === 0) return undefined
  const match = parts[0].match(/^(.+?)\s*(\*+\s*)?([A-Za-z_]\w*(?:\s*\[[^\]]*\])?)$/)
  if (!match) return undefined
  return {
    baseType: normalizeType(match[1]),
    declarators: [`${match[2] ?? ''}${match[3]}`, ...parts.slice(1)],
  }
}

function parseFieldDeclarator(baseType, rawName) {
  let text = rawName.trim()
  let pointer = ''
  while (text.startsWith('*')) {
    pointer += ' *'
    text = text.slice(1).trim()
  }
  const name = text.replace(/\[[^\]]*\]/g, '').trim()
  if (!/^[A-Za-z_]\w*$/.test(name)) return undefined
  return {
    name,
    cType: normalizeType(`${baseType}${pointer}`),
  }
}

function parseRawStructs(source) {
  const structs = new Map()
  const pattern = /typedef\s+(struct|union)\s+(SDL_\w+)\s*\{([\s\S]*?)\}\s*\2\s*;/g
  for (const match of source.matchAll(pattern)) {
    structs.set(match[2], {
      cName: match[2],
      kind: match[1],
      fields: parseRawFieldDeclarations(match[3]),
    })
  }
  return structs
}

function parseRawFieldDeclarations(body) {
  const fields = new Map()
  for (const statement of body.split(';')) {
    const text = statement.trim()
    if (!text) continue
    const parsed = parseFieldStatement(text)
    if (!parsed) continue
    for (const rawName of parsed.declarators) {
      const declarator = parseFieldDeclarator(parsed.baseType, rawName)
      if (!declarator) continue
      fields.set(declarator.name, declarator)
    }
  }
  return fields
}

function parseValueStructs(source) {
  const structs = new Map()
  const pattern = /typedef\s+(struct|union)\s+(SDL_\w+)\s*\{([\s\S]*?)\}\s*\2\s*;/g
  for (const match of source.matchAll(pattern)) {
    const cName = match[2]
    if (!configuredValueStructs.has(cName)) continue
    const kind = match[1]
    const fields = kind === 'struct' ? parseFieldDeclarations(match[3]) : []
    const mbtName = typeNameFromOpaque(cName)
    structs.set(cName, {
      cName,
      kind,
      mbtName,
      makeName: valueStructMakeName(mbtName),
      fields,
      accessors: [],
    })
  }
  return structs
}

function parseNumericLiteral(value) {
  let text = value.trim()
  text = text.replace(/SDL_UINT64_C\(([^)]+)\)/g, '$1')
  text = text.replace(/SDL_UINT32_C\(([^)]+)\)/g, '$1')
  text = text.replace(/[uUlL]+$/g, '')
  if (/^\(-?\d+\)$/.test(text)) text = text.slice(1, -1)
  if (/^0x[0-9a-fA-F]+$/.test(text) || /^-?\d+$/.test(text)) return text
  return undefined
}

function parseStringLiteral(value) {
  const match = value.trim().match(/^"((?:\\.|[^"\\])*)"/)
  return match ? `b"${match[1]}"` : undefined
}

function numericConstant(name, literal) {
  return { literal, type: constType(name) }
}

function stringConstant(literal) {
  return { literal, type: 'Bytes' }
}

function parseDefineConstants(source) {
  const constants = new Map()
  for (const match of source.matchAll(/^\s*#define\s+(SDL_[A-Z0-9_]+)\s+([^\r\n]+)/gm)) {
    const name = match[1]
    if (!constantPrefixes.some((prefix) => name.startsWith(prefix))) continue
    const value = match[2]
    const numeric = parseNumericLiteral(value.split(/\s+/)[0])
    if (numeric !== undefined) {
      constants.set(name, numericConstant(name, numeric))
      continue
    }
    const string = parseStringLiteral(value)
    if (string !== undefined) constants.set(name, stringConstant(string))
  }
  return constants
}

function parseEnumConstants(source) {
  const constants = new Map()
  for (const enumMatch of source.matchAll(
    /typedef\s+enum\s+\w+\s*\{([\s\S]*?)\}\s*(SDL_\w+)\s*;/g,
  )) {
    let nextValue = 0
    const entries = enumMatch[1].split(',')
    for (const rawEntry of entries) {
      const entry = rawEntry.trim()
      if (!entry) continue
      const match = entry.match(/^(SDL_[A-Z0-9_]+)(?:\s*=\s*([^,]+))?$/)
      if (!match) continue
      const name = match[1]
      if (!constantPrefixes.some((prefix) => name.startsWith(prefix))) continue
      if (match[2]) {
        const literal = parseNumericLiteral(match[2])
        if (literal === undefined) continue
        constants.set(name, numericConstant(name, literal))
        nextValue = Number.parseInt(literal)
      } else {
        constants.set(name, numericConstant(name, String(nextValue)))
      }
      nextValue += 1
    }
  }
  return constants
}

function splitParams(params) {
  const text = params.trim()
  if (text === '' || text === 'void') return []
  return text.split(',').map((param, index) => {
    const normalized = normalizeType(param)
    const match = normalized.match(/^(.*?)([A-Za-z_]\w*)$/)
    if (!match) throw new Error(`Cannot parse parameter: ${param}`)
    return {
      source: normalized,
      name: match[2] || `arg${index}`,
      type: normalizeType(match[1]),
    }
  })
}

function parseFunctions(source, opaqueTypes, valueStructs) {
  const compact = stripComments(source).replace(/\s+/g, ' ')
  const functions = []
  const pattern = /extern SDL_DECLSPEC (.*?) SDLCALL (SDL_\w+)\((.*?)\);/g
  for (const match of compact.matchAll(pattern)) {
    const cName = match[2]
    if (!functionAllowList.has(cName)) continue
    const returnType = applyReturnConfig(
      configuredReturn(cName),
      mapType({ type: match[1], opaqueTypes, valueStructs, position: 'return' }),
    )
    if (!returnType) continue
    const params = splitParams(match[3])
    const mappedParams = []
    let supported = true
    for (const param of params) {
      const paramConfig = configuredParam(cName, param.name)
      if (paramConfig.passing === 'null') {
        mappedParams.push({
          ...param,
          mapped: mappedType({ mbt: 'Unit', c: 'void', kind: AbiKind.ImplicitNullParam }),
        })
        continue
      }
      const mapped = mapType({ type: param.type, opaqueTypes, valueStructs, position: 'param' })
      if (!mapped) {
        supported = false
        break
      }
      mappedParams.push({
        ...param,
        mapped: applyParamConfig(paramConfig, mapped),
      })
    }
    if (!supported) continue
    const rawName = toSnake(cName)
    const mbtName = moonbitFunctionName(cName, rawName)
    functions.push({
      cName,
      rawName,
      externName: mbtName,
      wrapperName: mbtName,
      returnType,
      params: mappedParams,
    })
  }
  return functions
}

function applyReturnConfig(returnConfig, mapped) {
  if (!mapped) return mapped
  if (returnConfig.ownership === 'borrowed' && mapped.abi.kind === AbiKind.ResourcePointer) {
    return {
      ...mapped,
      abi: abi(AbiKind.ResourcePointer, { ...mapped.abi, ownership: 'borrowed' }),
    }
  }
  return mapped
}

function applyParamConfig(paramConfig, mapped) {
  if (paramConfig.nullable === true && mapped.abi.kind === AbiKind.ValueStructParam) {
    return { ...mapped, abi: abi(AbiKind.NullableValueStructParam, mapped.abi) }
  }
  if (paramConfig.emptyAsNull === true && mapped.abi.kind === AbiKind.BytesParam) {
    return { ...mapped, abi: abi(AbiKind.BytesParam, { ...mapped.abi, emptyAsNull: true }) }
  }
  return mapped
}

function isMbtParam(param) {
  return !isAbiKind(param.mapped, AbiKind.ImplicitNullParam)
}

function parseFunctionDeclarationNames(source) {
  const compact = stripComments(source).replace(/\s+/g, ' ')
  const names = new Set()
  const pattern = /extern SDL_DECLSPEC (.*?) SDLCALL (SDL_\w+)\((.*?)\);/g
  for (const match of compact.matchAll(pattern)) {
    names.add(match[2])
  }
  return names
}

function constType(name) {
  if (name.endsWith('_ADAPTIVE')) return 'Int'
  if (name.startsWith('SDL_WINDOW_')) return 'UInt64'
  return 'UInt'
}

function abiKind(mapped) {
  return mapped.abi.kind
}

function isAbiKind(mapped, ...kinds) {
  return kinds.includes(abiKind(mapped))
}

function borrowedParams(params) {
  return params.filter(
    (param) =>
      !isAbiKind(param.mapped, AbiKind.ImplicitNullParam) &&
      (param.mapped.mbt === 'Bytes' ||
        isAbiKind(
          param.mapped,
          AbiKind.IntOutParam,
          AbiKind.FloatOutParam,
          AbiKind.PointerOutParam,
          AbiKind.OpaquePointer,
          AbiKind.ValueStructParam,
          AbiKind.NullableValueStructParam,
          AbiKind.ResourcePointer,
        )),
  )
}

function wrapperNeedsBytesParam(mapped) {
  return isAbiKind(mapped, AbiKind.ValueStructParam, AbiKind.NullableValueStructParam)
}

function isCStringReturn(mapped) {
  return isAbiKind(mapped, AbiKind.CStringReturn, AbiKind.OwnedCStringReturn)
}

function cFunctionReturnType(mapped) {
  return isCStringReturn(mapped) ? 'moonbit_bytes_t' : mapped.c
}

function cParamDeclarations(param) {
  if (!isMbtParam(param)) return []
  const result = [`${param.mapped.c} ${param.name}`]
  if (isAbiKind(param.mapped, AbiKind.NullableValueStructParam)) {
    result.push(`int32_t has_${param.name}`)
  }
  return result
}

function cOutParamLocal(param) {
  if (isAbiKind(param.mapped, AbiKind.IntOutParam)) return `  int ${param.name}_value = 0;`
  if (isAbiKind(param.mapped, AbiKind.FloatOutParam)) {
    return `  float ${param.name}_value = 0.0f;`
  }
  if (isAbiKind(param.mapped, AbiKind.PointerOutParam)) {
    return `  void *${param.name}_value = NULL;`
  }
  return undefined
}

function cValueStructCast(param) {
  const qualifier = param.mapped.abi.isConst ? 'const ' : ''
  return `(${qualifier}${param.mapped.cType} *)${param.name}`
}

function cCallArgument(fn, param) {
  if (fn.cName === 'SDL_CreateRenderer' && param.name === 'name') {
    return `(Moonbit_array_length(${param.name}) == 0 ? NULL : (const char *)${param.name})`
  }
  switch (abiKind(param.mapped)) {
    case AbiKind.ImplicitNullParam:
      return 'NULL'
    case AbiKind.BytesParam:
      return param.mapped.abi.emptyAsNull
        ? `(Moonbit_array_length(${param.name}) == 0 ? NULL : (const char *)${param.name})`
        : `(const char *)${param.name}`
    case AbiKind.VoidBytesParam:
      return `(const void *)${param.name}`
    case AbiKind.ResourcePointer:
      return `${resourceHelperPrefix(param.mapped.cType)}_ptr(${param.name})`
    case AbiKind.IntOutParam:
    case AbiKind.FloatOutParam:
    case AbiKind.PointerOutParam:
      return `&${param.name}_value`
    case AbiKind.ValueStructParam:
      return cValueStructCast(param)
    case AbiKind.NullableValueStructParam:
      return `has_${param.name} ? ${cValueStructCast(param)} : NULL`
    default:
      return param.name
  }
}

function cOutParamCopyLine(param) {
  const cast = isAbiKind(param.mapped, AbiKind.IntOutParam) ? '(int32_t)' : ''
  return `  if (${param.name} != NULL) *${param.name} = ${cast}${param.name}_value;`
}

function cReturnLines(mapped, expression) {
  if (mapped.mbt === 'Unit') return [`  ${expression};`]
  if (isAbiKind(mapped, AbiKind.CStringReturn)) {
    return [`  return moonbit_cstring_to_bytes(${expression});`]
  }
  if (isAbiKind(mapped, AbiKind.OwnedCStringReturn)) {
    return [
      `  char *result = ${expression};`,
      '  moonbit_bytes_t bytes = moonbit_cstring_to_bytes(result);',
      '  SDL_free(result);',
      '  return bytes;',
    ]
  }
  if (isAbiKind(mapped, AbiKind.ResourcePointer)) {
    const suffix = mapped.abi.ownership === 'borrowed' ? '_borrowed_make' : '_make'
    return [`  return ${resourceHelperPrefix(mapped.cType)}${suffix}(${expression});`]
  }
  return [`  return ${expression};`]
}

function emitMbtParams(params, useBytesForValueStructs) {
  return params
    .filter(isMbtParam)
    .flatMap((param) => {
      const mbt =
        useBytesForValueStructs && wrapperNeedsBytesParam(param.mapped) ? 'Bytes' : param.mapped.mbt
      const result = [`${param.name} : ${mbt}`]
      if (isAbiKind(param.mapped, AbiKind.NullableValueStructParam)) {
        result.push(`has_${param.name} : Bool`)
      }
      return result
    })
    .join(', ')
}

function emitBorrowAnnotations(lines, params) {
  const borrowed = borrowedParams(params)
  lines.push('///|')
  if (borrowed.length > 0) {
    lines.push(`#borrow(${borrowed.map((param) => param.name).join(', ')})`)
  }
}

function emitExtern(lines, visibility, name, params, returnType, cSymbol) {
  emitBorrowAnnotations(lines, params)
  const paramsText = params
    .filter(isMbtParam)
    .map((param) => `${param.name} : ${param.mapped.mbt}`)
    .join(', ')
  const ret = returnType.mbt === 'Unit' ? '' : ` -> ${returnType.mbt}`
  lines.push(`${visibility}extern "c" fn ${name}(${paramsText})${ret} = "${cSymbol}"`)
  lines.push('')
}

function emitValueStructs(lines, valueStructs) {
  for (const valueStruct of [...valueStructs.values()].sort((a, b) =>
    a.mbtName.localeCompare(b.mbtName),
  )) {
    const params = valueStruct.fields.map((field) => `${field.name} : ${field.mbt}`).join(', ')
    const args = valueStruct.fields.map((field) => field.name).join(', ')
    lines.push('///|')
    lines.push(`struct ${valueStruct.mbtName} {`)
    lines.push('  bytes : Bytes')
    lines.push('}')
    lines.push('')
    lines.push('///|')
    lines.push(
      `extern "c" fn ${valueStruct.makeName}_make(${params}) -> Bytes = "${cStubSymbol(`${valueStruct.makeName}_make`)}"`,
    )
    lines.push('')
    lines.push('///|')
    lines.push(
      `pub fn ${valueStruct.mbtName}::${valueStruct.mbtName}(${params}) -> ${valueStruct.mbtName} {`,
    )
    lines.push(`  { bytes: ${valueStruct.makeName}_make(${args}) }`)
    lines.push('}')
    lines.push('')
    lines.push('///|')
    lines.push(`pub fn ${valueStruct.mbtName}::to_bytes(self : Self) -> Bytes {`)
    lines.push('  self.bytes')
    lines.push('}')
    lines.push('')
    for (const accessor of valueStruct.accessors) {
      const accessorName = `${valueStruct.makeName}_${accessor.name}`
      lines.push('///|')
      lines.push('#borrow(bytes)')
      lines.push(
        `extern "c" fn ${accessorName}(bytes : Bytes) -> ${accessor.mapped.mbt} = "${cStubSymbol(accessorName)}"`,
      )
      lines.push('')
      lines.push('///|')
      lines.push(
        `pub fn ${valueStruct.mbtName}::${accessor.name}(self : Self) -> ${accessor.mapped.mbt} {`,
      )
      lines.push(`  ${accessorName}(self.to_bytes())`)
      lines.push('}')
      lines.push('')
    }
  }
}

function resolveFieldPathType(rawStructs, cName, fieldPath) {
  let currentType = cName
  for (let i = 0; i < fieldPath.length; i += 1) {
    const rawStruct = rawStructs.get(currentType)
    if (!rawStruct) return undefined
    const field = rawStruct.fields.get(fieldPath[i])
    if (!field) return undefined
    if (i === fieldPath.length - 1) return field.cType
    currentType = normalizeType(field.cType).replace(/^const\s+/, '')
  }
  return undefined
}

function buildValueStructFieldAccessorGroups(rawStructs, opaqueTypes, valueStructs) {
  const groups = []
  for (const [cName, valueStructConfig] of configuredValueStructs) {
    const accessorsConfig = valueStructConfig.accessors
    if (!accessorsConfig) continue
    const valueStruct = valueStructs.get(cName)
    const accessors = []
    for (const [field, accessorConfig] of Object.entries(accessorsConfig)) {
      const fieldPath = field.split('.')
      const name =
        typeof accessorConfig === 'string'
          ? accessorConfig
          : (accessorConfig.name ?? toSnake(`${cName}_${field}`))
      const cType =
        typeof accessorConfig === 'object' && accessorConfig.type
          ? accessorConfig.type
          : resolveFieldPathType(rawStructs, cName, fieldPath)
      const mapped = cType
        ? mapType({ type: cType, position: 'return', opaqueTypes, valueStructs })
        : undefined
      accessors.push({
        field,
        fieldPath,
        name,
        cType,
        mapped,
      })
    }
    groups.push({ cName, valueStruct, accessors })
  }
  return groups
}

function attachValueStructFieldAccessors(accessorGroups) {
  for (const group of accessorGroups) {
    group.valueStruct.accessors.push(...group.accessors)
  }
}

function emitMbt(opaqueTypes, valueStructs, constants, functions) {
  const lines = getGenLines()
  for (const [cName, mbtType] of [...opaqueTypes.entries()].sort((a, b) =>
    a[1].localeCompare(b[1]),
  )) {
    if (configuredResources.has(cName)) {
      const isNullName = `${resourceBaseName(cName)}_is_null`
      lines.push('///|')
      lines.push(`pub type ${mbtType}`)
      lines.push('')
      lines.push('///|')
      lines.push('#borrow(resource)')
      lines.push(
        `extern "c" fn ${isNullName}(resource : ${mbtType}) -> Bool = "${cStubSymbol(isNullName)}"`,
      )
      lines.push('')
      lines.push('///|')
      lines.push(`pub fn ${mbtType}::is_null(self : Self) -> Bool {`)
      lines.push(`  ${isNullName}(self)`)
      lines.push('}')
      lines.push('')
    } else {
      lines.push('///|')
      lines.push('#external')
      lines.push(`pub type ${mbtType}`)
      lines.push('')
      lines.push('///|')
      lines.push(`pub fn ${mbtType}::to_pointer(self : Self) -> Pointer = "%identity"`)
      lines.push('')
      lines.push('///|')
      lines.push(`pub fn ${mbtType}::is_null(self : Self) -> Bool {`)
      lines.push('  self.to_pointer().is_null()')
      lines.push('}')
      lines.push('')
    }
  }
  emitValueStructs(lines, valueStructs)
  for (const [name, value] of [...constants.entries()].sort()) {
    lines.push('///|')
    lines.push(`pub const ${toMoonbitConst(name)} : ${value.type} = ${value.literal}`)
    lines.push('')
  }
  for (const fn of functions) {
    const hasValueStructParam = fn.params.some((param) => wrapperNeedsBytesParam(param.mapped))
    if (!hasValueStructParam) {
      emitExtern(lines, 'pub ', fn.externName, fn.params, fn.returnType, cStubSymbol(fn.rawName))
      continue
    }
    const ffiParams = fn.params.flatMap((param) => {
      const mapped = wrapperNeedsBytesParam(param.mapped)
        ? { ...param.mapped, mbt: 'Bytes' }
        : param.mapped
      const result = [{ ...param, mapped }]
      if (isAbiKind(param.mapped, AbiKind.NullableValueStructParam)) {
        result.push({
          source: 'bool',
          name: `has_${param.name}`,
          type: 'bool',
          mapped: mappedType({ mbt: 'Bool', c: 'int32_t', cType: 'bool' }),
        })
      }
      return result
    })
    const ffiName = `${fn.externName}_ffi`
    emitExtern(lines, '', ffiName, ffiParams, fn.returnType, cStubSymbol(`${fn.rawName}_ffi`))
    lines.push('///|')
    const params = emitMbtParams(fn.params, false)
    const ret = fn.returnType.mbt === 'Unit' ? '' : ` -> ${fn.returnType.mbt}`
    const args = fn.params
      .filter(isMbtParam)
      .flatMap((param) => {
        if (wrapperNeedsBytesParam(param.mapped)) {
          const result = [`${param.name}.to_bytes()`]
          if (isAbiKind(param.mapped, AbiKind.NullableValueStructParam)) {
            result.push(`has_${param.name}`)
          }
          return result
        }
        return [param.name]
      })
      .join(', ')
    lines.push(`pub fn ${fn.wrapperName}(${params})${ret} {`)
    lines.push(`  ${ffiName}(${args})`)
    lines.push('}')
    lines.push('')
  }
  return lines.join('\n')
}

function markResourceUsage(usages, cName, key) {
  const usage = usages.get(cName) ?? {
    ptr: false,
    make: false,
    destroy: false,
    exportDestroy: false,
    destroySymbol: undefined,
    borrowedMake: false,
    isNull: false,
  }
  usage[key] = true
  usages.set(cName, usage)
}

function functionResourceUsages(functions, exportedResourceTypes) {
  const usages = new Map()
  for (const cName of exportedResourceTypes) {
    markResourceUsage(usages, cName, 'ptr')
    markResourceUsage(usages, cName, 'isNull')
  }
  for (const fn of functions) {
    if (isAbiKind(fn.returnType, AbiKind.ResourcePointer)) {
      markResourceUsage(usages, fn.returnType.cType, 'ptr')
      if (fn.returnType.abi.ownership === 'borrowed') {
        markResourceUsage(usages, fn.returnType.cType, 'borrowedMake')
      } else {
        markResourceUsage(usages, fn.returnType.cType, 'make')
        markResourceUsage(usages, fn.returnType.cType, 'destroy')
      }
    }
    for (const param of fn.params) {
      if (isAbiKind(param.mapped, AbiKind.ResourcePointer)) {
        markResourceUsage(usages, param.mapped.cType, 'ptr')
      }
    }
    if (destroysResource(fn)) {
      const cName = fn.params[0].mapped.cType
      markResourceUsage(usages, cName, 'destroy')
      markResourceUsage(usages, cName, 'exportDestroy')
      usages.get(cName).destroySymbol = cStubSymbol(fn.rawName)
    }
  }
  return usages
}

function destroysResource(fn) {
  const param = fn.params[0]
  return (
    fn.returnType.mbt === 'Unit' &&
    fn.params.length === 1 &&
    param?.mapped &&
    isAbiKind(param.mapped, AbiKind.ResourcePointer) &&
    configuredResources.get(param.mapped.cType)?.destroy === fn.cName
  )
}

function emitResourceHelpers(lines, resourceUsages) {
  for (const [cName, usage] of [...resourceUsages.entries()].sort((a, b) =>
    a[0].localeCompare(b[0]),
  )) {
    const structName = resourceStructName(cName)
    const prefix = resourceHelperPrefix(cName)
    const destroy = configuredResources.get(cName)?.destroy
    lines.push(`typedef struct {`)
    lines.push(`  ${cName} *ptr;`)
    lines.push(`} ${structName};`)
    lines.push('')
    lines.push(`static ${cName} *${prefix}_ptr(${structName} *self) {`)
    lines.push('  return self == NULL ? NULL : self->ptr;')
    lines.push('}')
    lines.push('')
    if (usage.destroy && destroy) {
      const visibility = usage.exportDestroy ? '' : 'static '
      const destroySymbol = usage.destroySymbol ?? `${prefix}_destroy`
      if (usage.exportDestroy) lines.push('MOONBIT_FFI_EXPORT')
      lines.push(`${visibility}void ${destroySymbol}(void *self) {`)
      lines.push(`  ${structName} *resource = (${structName} *)self;`)
      lines.push('  if (resource == NULL || resource->ptr == NULL) {')
      lines.push('    return;')
      lines.push('  }')
      lines.push(`  ${destroy}(resource->ptr);`)
      lines.push('  resource->ptr = NULL;')
      lines.push('}')
      lines.push('')
    }
    if (usage.borrowedMake || (usage.make && !(usage.destroy && destroy))) {
      lines.push(`static void ${prefix}_borrowed_destroy(void *self) {`)
      lines.push('  (void)self;')
      lines.push('}')
      lines.push('')
    }
    if (usage.make) {
      lines.push(`static ${structName} *${prefix}_make(${cName} *ptr) {`)
      lines.push(`  ${structName} *resource = (${structName} *)moonbit_make_external_object(`)
      lines.push(
        usage.destroy && destroy
          ? `    ${usage.destroySymbol ?? `${prefix}_destroy`},`
          : `    ${prefix}_borrowed_destroy,`,
      )
      lines.push(`    sizeof(${structName})`)
      lines.push('  );')
      lines.push('  resource->ptr = ptr;')
      lines.push('  return resource;')
      lines.push('}')
      lines.push('')
    }
    if (usage.borrowedMake) {
      lines.push(`static ${structName} *${prefix}_borrowed_make(${cName} *ptr) {`)
      lines.push(`  ${structName} *resource = (${structName} *)moonbit_make_external_object(`)
      lines.push(`    ${prefix}_borrowed_destroy,`)
      lines.push(`    sizeof(${structName})`)
      lines.push('  );')
      lines.push('  resource->ptr = ptr;')
      lines.push('  return resource;')
      lines.push('}')
      lines.push('')
    }
    if (usage.isNull) {
      lines.push('MOONBIT_FFI_EXPORT')
      lines.push(`int32_t moonbit_sdl_${resourceBaseName(cName)}_is_null(${structName} *self) {`)
      lines.push(`  return ${prefix}_ptr(self) == NULL;`)
      lines.push('}')
      lines.push('')
    }
  }
}

function emitC(opaqueTypes, valueStructs, functions) {
  const exportedResourceTypes = new Set(
    [...opaqueTypes.keys()].filter((cName) => configuredResources.has(cName)),
  )
  const resourceUsages = functionResourceUsages(functions, exportedResourceTypes)
  const hasFunctionBodies = functions.some((fn) => !destroysResource(fn))
  if (valueStructs.size === 0 && resourceUsages.size === 0 && !hasFunctionBodies) {
    return undefined
  }
  const needsCStringHelper =
    functions.some((fn) => isCStringReturn(fn.returnType)) ||
    [...valueStructs.values()].some((valueStruct) =>
      valueStruct.accessors.some((accessor) => isAbiKind(accessor.mapped, AbiKind.CStringReturn)),
    )
  const needsMoonbit =
    hasFunctionBodies ||
    valueStructs.size > 0 ||
    resourceUsages.size > 0
  const needsStddef =
    resourceUsages.size > 0 ||
    functions.some((fn) =>
      fn.params.some((param) => fn.cName === 'SDL_CreateRenderer' && param.name === 'name'),
    )
  const needsStdint =
    resourceUsages.size > 0 ||
    functions.some(
      (fn) =>
        fn.returnType.c === 'int32_t' ||
        fn.params.some((param) => param.mapped.c.includes('int32_t')),
    ) ||
    [...valueStructs.values()].some((valueStruct) =>
      valueStruct.accessors.some((accessor) => accessor.mapped.c.includes('int32_t')),
    )
  const needsString = valueStructs.size > 0
  const lines = getGenLines()
  lines.push(`#include "${config.cInclude}"`)
  if (needsMoonbit) lines.push('#include <moonbit.h>')
  if (needsStddef) lines.push('#include <stddef.h>')
  if (needsStdint) lines.push('#include <stdint.h>')
  if (needsString) lines.push('#include <string.h>')
  lines.push('')
  if (needsCStringHelper) {
    lines.push('moonbit_bytes_t moonbit_cstring_to_bytes(const char *str);')
    lines.push('')
  }
  emitResourceHelpers(lines, resourceUsages)
  for (const valueStruct of [...valueStructs.values()].sort((a, b) =>
    a.mbtName.localeCompare(b.mbtName),
  )) {
    const params = valueStruct.fields.map((field) => `${field.c} ${field.name}`).join(', ')
    lines.push('MOONBIT_FFI_EXPORT')
    lines.push(`moonbit_bytes_t moonbit_sdl_${valueStruct.makeName}_make(${params}) {`)
    lines.push(`  ${valueStruct.cName} value = { 0 };`)
    for (const field of valueStruct.fields) {
      lines.push(`  value.${field.name} = ${field.name};`)
    }
    lines.push(`  moonbit_bytes_t bytes = moonbit_make_bytes(sizeof(${valueStruct.cName}), 0);`)
    lines.push(`  memcpy(bytes, &value, sizeof(${valueStruct.cName}));`)
    lines.push('  return bytes;')
    lines.push('}')
    lines.push('')
    for (const accessor of valueStruct.accessors) {
      lines.push('MOONBIT_FFI_EXPORT')
      lines.push(
        `${accessor.mapped.c} moonbit_sdl_${valueStruct.makeName}_${accessor.name}(moonbit_bytes_t self) {`,
      )
      const access = `((${valueStruct.cName} *)self)->${accessor.fieldPath.join('.')}`
      lines.push(...cReturnLines(accessor.mapped, access))
      lines.push('}')
      lines.push('')
    }
  }
  for (const fn of functions) {
    if (destroysResource(fn)) continue
    const cReturn = cFunctionReturnType(fn.returnType)
    const hasValueStructParam = fn.params.some((param) => wrapperNeedsBytesParam(param.mapped))
    const cRawName = hasValueStructParam ? `${fn.rawName}_ffi` : fn.rawName
    const params = fn.params.flatMap((param) => cParamDeclarations(param)).join(', ')
    lines.push('MOONBIT_FFI_EXPORT')
    lines.push(`${cReturn} moonbit_sdl_${cRawName}(${params || 'void'}) {`)
    for (const param of fn.params) {
      const local = cOutParamLocal(param)
      if (local) lines.push(local)
    }
    const callArgs = fn.params.map((param) => cCallArgument(fn, param)).join(', ')
    const call = `${fn.cName}(${callArgs})`
    const outParams = fn.params.filter((param) =>
      isAbiKind(param.mapped, AbiKind.IntOutParam, AbiKind.FloatOutParam, AbiKind.PointerOutParam),
    )
    const copyOutParams = () => {
      for (const param of outParams) {
        lines.push(cOutParamCopyLine(param))
      }
    }
    if (outParams.length === 0) {
      lines.push(...cReturnLines(fn.returnType, call))
      lines.push('}')
      lines.push('')
      continue
    }
    if (fn.returnType.mbt === 'Unit') {
      lines.push(`  ${call};`)
      copyOutParams()
    } else if (isAbiKind(fn.returnType, AbiKind.CStringReturn)) {
      lines.push(`  const char *result = ${call};`)
      copyOutParams()
      lines.push('  return moonbit_cstring_to_bytes(result);')
    } else if (isAbiKind(fn.returnType, AbiKind.OwnedCStringReturn)) {
      lines.push(`  char *result = ${call};`)
      copyOutParams()
      lines.push('  moonbit_bytes_t bytes = moonbit_cstring_to_bytes(result);')
      lines.push('  SDL_free(result);')
      lines.push('  return bytes;')
    } else if (isAbiKind(fn.returnType, AbiKind.ResourcePointer)) {
      lines.push(`  ${fn.returnType.cType} *result = ${call};`)
      copyOutParams()
      const suffix = fn.returnType.abi.ownership === 'borrowed' ? '_borrowed_make' : '_make'
      lines.push(`  return ${resourceHelperPrefix(fn.returnType.cType)}${suffix}(result);`)
    } else {
      lines.push(`  ${cReturn} result = ${call};`)
      copyOutParams()
      lines.push('  return result;')
    }
    lines.push('}')
    lines.push('')
  }
  return lines.join('\n')
}

function mergeMaps(maps) {
  return new Map(maps.flatMap((map) => [...map.entries()]))
}

function mergeSets(sets) {
  return new Set(sets.flatMap((set) => [...set]))
}

function uniqueBy(values, keyOf) {
  const seen = new Map()
  const duplicates = []
  for (const value of values) {
    const key = keyOf(value)
    if (seen.has(key)) {
      duplicates.push([key, seen.get(key), value])
    } else {
      seen.set(key, value)
    }
  }
  return duplicates
}

function validateConfig({ headerData, opaqueTypes, valueStructs, functions, fieldAccessorGroups }) {
  const errors = []
  const declaredFunctions = mergeSets(headerData.map((header) => header.declaredFunctions))
  const functionsByCName = new Map(functions.map((fn) => [fn.cName, fn]))
  for (const [name] of uniqueBy(functionConfigs, (fn) => fn.name)) {
    errors.push(`functions contains duplicate entry ${name}`)
  }
  for (const fnConfig of functionConfigs) {
    if (!/^[A-Za-z_]\w*$/.test(fnConfig.name ?? '')) {
      errors.push('functions contains an entry without a valid name')
    }
    if (!fnConfig.params || typeof fnConfig.params !== 'object' || Array.isArray(fnConfig.params)) {
      errors.push(`functions.${fnConfig.name ?? '<unknown>'}.params must be an object`)
    }
    if (!fnConfig.return || typeof fnConfig.return !== 'object' || Array.isArray(fnConfig.return)) {
      errors.push(`functions.${fnConfig.name ?? '<unknown>'}.return must be an object`)
    }
  }
  const duplicateFunctions = uniqueBy(functions, (fn) => fn.cName)
  for (const [name] of duplicateFunctions) {
    errors.push(`function ${name} was generated more than once`)
  }

  for (const cName of functionAllowList) {
    if (!declaredFunctions.has(cName)) {
      errors.push(`functions contains ${cName}, but no matching SDL declaration was found`)
    } else if (!functionsByCName.has(cName)) {
      errors.push(`functions contains ${cName}, but its signature is not supported`)
    }
  }

  for (const [cName, renamed] of functionRenames) {
    if (!functionAllowList.has(cName)) {
      errors.push(`renames.functions.${cName} references a function missing from functions`)
    }
    if (!/^[a-z_]\w*$/.test(renamed)) {
      errors.push(`renames.functions.${cName} uses invalid MoonBit name ${renamed}`)
    }
  }

  for (const [externName, first, second] of uniqueBy(functions, (fn) => fn.externName)) {
    errors.push(
      `functions ${first.cName} and ${second.cName} both generate MoonBit name ${externName}`,
    )
  }
  for (const [rawName, first, second] of uniqueBy(functions, (fn) => fn.rawName)) {
    errors.push(`functions ${first.cName} and ${second.cName} both generate C stub name ${rawName}`)
  }

  for (const cName of configuredValueStructs.keys()) {
    if (!valueStructs.has(cName)) {
      errors.push(`valueStructs contains ${cName}, but no matching SDL struct/union was found`)
    }
  }

  const fieldAccessorKeys = new Set()
  for (const group of fieldAccessorGroups) {
    if (!group.valueStruct) {
      errors.push(`valueStructs.${group.cName}.accessors references unknown value struct`)
      continue
    }
    for (const accessor of group.accessors) {
      const key = `${group.cName}.${accessor.name}`
      if (fieldAccessorKeys.has(key)) {
        errors.push(`valueStructs.${group.cName}.accessors has duplicate accessor ${key}`)
      }
      fieldAccessorKeys.add(key)
      if (!/^[a-z_]\w*$/.test(accessor.name)) {
        errors.push(
          `valueStructs.${group.cName}.accessors.${accessor.field} uses invalid MoonBit name ${accessor.name}`,
        )
      }
      if (!accessor.cType) {
        errors.push(
          `valueStructs.${group.cName}.accessors.${accessor.field} references unknown field path`,
        )
        continue
      }
      if (!accessor.mapped || accessor.mapped.mbt === 'Unit') {
        errors.push(
          `valueStructs.${group.cName}.accessors.${accessor.field} uses unsupported return type ${accessor.cType}`,
        )
      }
    }
  }

  for (const [cName, resource] of configuredResources) {
    if (!opaqueTypes.has(cName)) {
      errors.push(`resources.${cName} references unknown opaque type`)
    }
    if (!resource.destroy) {
      errors.push(`resources.${cName} is missing destroy function`)
      continue
    }
    const destroyFn = functionsByCName.get(resource.destroy)
    if (!functionAllowList.has(resource.destroy)) {
      errors.push(`resources.${cName}.destroy references a function missing from functions`)
    } else if (!destroyFn) {
      errors.push(`resources.${cName}.destroy function ${resource.destroy} was not generated`)
    } else if (!destroysResource(destroyFn)) {
      errors.push(
        `resources.${cName}.destroy function ${resource.destroy} does not destroy ${cName}`,
      )
    }
  }

  for (const section of [
    'implicitNullParams',
    'nullableValueStructParams',
    'emptyBytesAsNullParams',
  ]) {
    if (config[section] !== undefined) {
      errors.push(`${section} is no longer used; move parameter policy into functions[].params`)
    }
  }

  const knownParamOptions = new Set(['emptyAsNull', 'nullable', 'passing'])
  const knownReturnOptions = new Set(['ownership'])
  for (const fnConfig of functionConfigs) {
    const fn = functionsByCName.get(fnConfig.name)
    if (fnConfig.return && typeof fnConfig.return === 'object' && !Array.isArray(fnConfig.return)) {
      for (const option of Object.keys(fnConfig.return)) {
        if (!knownReturnOptions.has(option)) {
          errors.push(`functions.${fnConfig.name}.return uses unknown option ${option}`)
        }
      }
      if (fnConfig.return.ownership !== undefined && fnConfig.return.ownership !== 'borrowed') {
        errors.push(`functions.${fnConfig.name}.return.ownership must be "borrowed"`)
      }
      if (
        fnConfig.return.ownership === 'borrowed' &&
        fn &&
        (!isAbiKind(fn.returnType, AbiKind.ResourcePointer) ||
          fn.returnType.abi.ownership !== 'borrowed')
      ) {
        errors.push(`functions.${fnConfig.name}.return.ownership is not a resource pointer return`)
      }
    }
    if (
      !fn ||
      !fnConfig.params ||
      typeof fnConfig.params !== 'object' ||
      Array.isArray(fnConfig.params)
    ) {
      continue
    }
    const paramsByName = new Map(fn.params.map((param) => [param.name, param]))
    for (const [paramName, paramConfig] of Object.entries(fnConfig.params)) {
      if (!paramConfig || typeof paramConfig !== 'object' || Array.isArray(paramConfig)) {
        errors.push(`functions.${fnConfig.name}.params.${paramName} must be an object`)
        continue
      }
      const param = paramsByName.get(paramName)
      if (!param) {
        errors.push(`functions.${fnConfig.name}.params references unknown parameter ${paramName}`)
        continue
      }
      for (const option of Object.keys(paramConfig)) {
        if (!knownParamOptions.has(option)) {
          errors.push(
            `functions.${fnConfig.name}.params.${paramName} uses unknown option ${option}`,
          )
        }
      }
      if (paramConfig.passing !== undefined && paramConfig.passing !== 'null') {
        errors.push(`functions.${fnConfig.name}.params.${paramName}.passing must be "null"`)
      }
      if (paramConfig.nullable !== undefined && paramConfig.nullable !== true) {
        errors.push(`functions.${fnConfig.name}.params.${paramName}.nullable must be true`)
      }
      if (paramConfig.emptyAsNull !== undefined && paramConfig.emptyAsNull !== true) {
        errors.push(`functions.${fnConfig.name}.params.${paramName}.emptyAsNull must be true`)
      }
      if (paramConfig.passing === 'null' && !isAbiKind(param.mapped, AbiKind.ImplicitNullParam)) {
        errors.push(`functions.${fnConfig.name}.params.${paramName}.passing cannot be applied`)
      }
      if (
        paramConfig.nullable === true &&
        !isAbiKind(param.mapped, AbiKind.NullableValueStructParam)
      ) {
        errors.push(
          `functions.${fnConfig.name}.params.${paramName}.nullable is not a value struct pointer parameter`,
        )
      }
      if (paramConfig.emptyAsNull === true) {
        if (!isAbiKind(param.mapped, AbiKind.BytesParam)) {
          errors.push(
            `functions.${fnConfig.name}.params.${paramName}.emptyAsNull is not a bytes parameter`,
          )
        } else if (param.mapped.abi.emptyAsNull !== true) {
          errors.push(`functions.${fnConfig.name}.params.${paramName}.emptyAsNull was not applied`)
        }
      }
    }
  }

  if (errors.length > 0) {
    const message = errors.map((err) => `- ${err}`).join('\n')
    throw new Error(`Invalid SDL sys generator config:\n${message}`)
  }
}

function writeGeneratedFile(file, content) {
  fs.writeFileSync(path.join(outDir, file), content)
}

function removeGeneratedFile(file) {
  const target = path.join(outDir, file)
  if (fs.existsSync(target)) fs.unlinkSync(target)
}

function main() {
  const headers = readHeaders()
  const headerData = headers.map((header) => ({
    ...header,
    declaredFunctions: parseFunctionDeclarationNames(header.source),
    opaqueTypes: parseOpaqueTypes(header.stripped),
    rawStructs: parseRawStructs(header.stripped),
    valueStructs: parseValueStructs(header.stripped),
    constants: new Map([
      ...parseDefineConstants(header.source),
      ...parseEnumConstants(header.stripped),
    ]),
  }))
  const opaqueTypes = mergeMaps(headerData.map((header) => header.opaqueTypes))
  const rawStructs = mergeMaps(headerData.map((header) => header.rawStructs))
  const valueStructs = mergeMaps(headerData.map((header) => header.valueStructs))
  for (const header of headerData) {
    header.functions = parseFunctions(header.source, opaqueTypes, valueStructs)
  }
  const constants = mergeMaps(headerData.map((header) => header.constants))
  const functions = headerData.flatMap((header) => header.functions)
  const fieldAccessorGroups = buildValueStructFieldAccessorGroups(
    rawStructs,
    opaqueTypes,
    valueStructs,
  )
  validateConfig({ headerData, opaqueTypes, valueStructs, functions, fieldAccessorGroups })
  attachValueStructFieldAccessors(fieldAccessorGroups)
  fs.mkdirSync(outDir, { recursive: true })
  let cStubCount = 0
  for (const header of headerData) {
    writeGeneratedFile(
      `${header.base}_gen.mbt`,
      emitMbt(header.opaqueTypes, header.valueStructs, header.constants, header.functions),
    )
    const cStub = emitC(header.opaqueTypes, header.valueStructs, header.functions)
    if (cStub) {
      writeGeneratedFile(`${header.base}_stub_gen.c`, cStub)
      cStubCount += 1
    } else {
      removeGeneratedFile(`${header.base}_stub_gen.c`)
    }
  }
  console.log(
    `Generated ${headers.length} MoonBit files, ${cStubCount} C stubs, ${opaqueTypes.size} opaque types, ${valueStructs.size} value structs, ${constants.size} constants, ${functions.length} functions.`,
  )
}

main()
