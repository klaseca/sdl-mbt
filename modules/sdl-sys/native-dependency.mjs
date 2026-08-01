import fs from 'node:fs'
import path from 'node:path'
import { spawnSync } from 'node:child_process'

const debugVariable = 'MOON_NATIVE_RESOLVE_DEBUG'

/**
 * @typedef {object} NativeTarget
 * @property {string} platform
 * @property {string} architecture
 */

/**
 * @typedef {object} NativeLibraryConfig
 * @property {string} linkName
 * @property {Record<string, string[]>} files
 */

/**
 * @typedef {object} NativeInstallLayout
 * @property {(installPath: string, layout: NativeTarget) => string[]} includeDirectories
 * @property {(installPath: string, layout: NativeTarget) => string[]} libraryDirectories
 */

/**
 * @typedef {object} NativeDependencyConfig
 * @property {string} packageName
 * @property {string[]} headers
 * @property {NativeLibraryConfig} library
 * @property {NativeProvider[]} providers
 * @property {Record<string, string>} [platformAliases]
 * @property {Record<string, string>} [architectureAliases]
 */

/**
 * @typedef {object} NativeLinkConfig
 * @property {string} package
 * @property {string[]} [link_libs]
 * @property {string[]} [link_search_paths]
 */

/**
 * @typedef {object} NativeDependency
 * @property {string} compileFlags
 * @property {NativeLinkConfig} linkConfig
 */

/**
 * @typedef {object} NativeDependencyCandidate
 * @property {string} source
 * @property {string} compileFlags
 * @property {string[]} libraries
 * @property {string[]} libraryDirectories
 * @property {string} [includeDirectory]
 * @property {string} [libraryFile]
 */

/**
 * @typedef {object} NativeResolutionContext
 * @property {NativeDependencyConfig} config
 * @property {Record<string, string>} environment
 * @property {NativeTarget} target
 * @property {NativeTarget} layout
 * @property {string[]} libraryFiles
 * @property {string[]} attempts
 * @property {boolean} debug
 */

/** @typedef {(context: NativeResolutionContext) => NativeDependencyCandidate | null} NativeProvider */

/**
 * @typedef {object} NativeProviderFactory
 * @property {(variable: string, installLayout: NativeInstallLayout) => NativeProvider} envInstallPath
 * @property {(packageName: string) => NativeProvider} pkgConfig
 * @property {(installLayout: NativeInstallLayout) => NativeProvider} vcpkg
 * @property {(installLayout: NativeInstallLayout) => NativeProvider} cmakePrefixPath
 * @property {NativeProvider} toolchainSearchPaths
 */

/** @type {NativeProviderFactory} */
export const nativeProvider = {
  envInstallPath: (variable, installLayout) => (context) =>
    resolveEnvInstallPath(context, variable, installLayout),
  pkgConfig: (packageName) => (context) => resolvePkgConfig(context, packageName),
  vcpkg: (installLayout) => (context) => resolveVcpkg(context, installLayout),
  cmakePrefixPath: (installLayout) => (context) =>
    resolveCmakePrefixPath(context, installLayout),
  toolchainSearchPaths: resolveToolchainSearchPaths,
}

/**
 * @param {NativeDependencyConfig} config
 * @param {NativeTarget} [target]
 * @returns {NativeDependency}
 */
export function resolveNativeDependency(config, target) {
  const moonBuildInput = readMoonBuildInput()
  const environment = moonBuildInput.env
  const resolvedTarget = target ??
    readMoonTarget(moonBuildInput) ?? {
      platform: process.platform,
      architecture: process.arch,
    }
  const layout = {
    platform: config.platformAliases?.[resolvedTarget.platform] ?? resolvedTarget.platform,
    architecture:
      config.architectureAliases?.[resolvedTarget.architecture] ?? resolvedTarget.architecture,
  }
  const libraryFiles = config.library.files[layout.platform] ?? config.library.files.default
  if (libraryFiles == null) {
    throw new TypeError(`Native dependency config has no library files for ${layout.platform}`)
  }

  const context = {
    config,
    environment,
    target: resolvedTarget,
    layout,
    libraryFiles,
    attempts: [],
    debug: environment[debugVariable] === '1',
  }

  trace(
    context,
    `target ${resolvedTarget.platform}/${resolvedTarget.architecture}, layout ${layout.platform}/${layout.architecture}`,
  )

  return createMoonDependency(context, discoverNativeDependency(context))
}

function discoverNativeDependency(context) {
  for (const provider of context.config.providers) {
    const dependency = provider(context)
    if (dependency != null) {
      return dependency
    }
  }

  throw resolutionError(
    context,
    `Could not resolve a native dependency for ${context.config.packageName}.`,
  )
}

function resolveEnvInstallPath(context, variable, installLayout) {
  const configuredPath = context.environment[variable]
  if (!configuredPath) {
    reject(context, `environment ${variable}`, 'environment variable is not set')
    return null
  }

  const installPath = unquote(configuredPath)
  if (!path.isAbsolute(installPath)) {
    reject(context, `environment ${variable}`, `path is not absolute: ${installPath}`)
    throw resolutionError(context, `${variable} must contain an absolute installation path.`)
  }

  const normalizedInstallPath = path.normalize(installPath)
  const dependency = resolveInstallPath(
    context,
    installLayout,
    `environment ${variable}`,
    normalizedInstallPath,
  )
  if (dependency == null) {
    throw resolutionError(
      context,
      `${variable} does not contain a usable development package: ${normalizedInstallPath}`,
    )
  }
  return dependency
}

function readMoonBuildInput() {
  let source
  try {
    source = fs.readFileSync(process.stdin.fd, 'utf8')
  } catch (error) {
    throw new Error('Failed to read MoonBit prebuild input from stdin', { cause: error })
  }

  if (source.trim() === '') {
    throw new Error('Received empty MoonBit prebuild input on stdin')
  }

  let parsed
  try {
    parsed = JSON.parse(source)
  } catch (error) {
    throw new Error('Received invalid JSON from MoonBit', { cause: error })
  }

  if (
    !isObject(parsed) ||
    !isObject(parsed.env) ||
    !isObject(parsed.paths) ||
    typeof parsed.paths.module_root !== 'string' ||
    parsed.paths.module_root === ''
  ) {
    throw new Error(
      'MoonBit prebuild input must contain an env object and paths.module_root string',
    )
  }
  return parsed
}

function isObject(value) {
  return typeof value === 'object' && value !== null && !Array.isArray(value)
}

function readMoonTarget(moonBuildInput) {
  const target = moonBuildInput.build?.target
  return isObject(target) &&
    typeof target.os === 'string' &&
    target.os !== '' &&
    typeof target.arch === 'string' &&
    target.arch !== ''
    ? { platform: target.os, architecture: target.arch }
    : undefined
}

function createMoonDependency(context, dependency) {
  trace(
    context,
    `selected ${dependency.source}: ${
      dependency.includeDirectory
        ? `headers ${dependency.includeDirectory}`
        : 'compiler inputs supplied by discovery source'
    }, ${
      dependency.libraryFile
        ? `library ${dependency.libraryFile}`
        : 'linker inputs supplied by discovery source'
    }`,
  )

  return {
    compileFlags: dependency.compileFlags,
    linkConfig: createMoonLinkConfig(context.config, dependency),
  }
}

function createMoonLinkConfig(config, dependency) {
  return {
    package: config.packageName,
    ...(dependency.libraries.length !== 0 ? { link_libs: dependency.libraries } : {}),
    ...(dependency.libraryDirectories.length !== 0
      ? { link_search_paths: dependency.libraryDirectories }
      : {}),
  }
}

function resolvePkgConfig(context, packageName) {
  const { environment } = context
  const commands = [...new Set([environment.PKG_CONFIG, 'pkg-config', 'pkgconf'].filter(Boolean))]
  const failures = []

  for (const configuredCommand of commands) {
    const command = unquote(configuredCommand)
    const exists = run(environment, command, ['--exists', packageName])
    if (!exists.ok) {
      failures.push(`${command}: ${exists.error}`)
      continue
    }

    const compileFlags = run(environment, command, ['--cflags', packageName])
    const libraryFlags = run(environment, command, ['--libs-only-l', packageName])
    const searchFlags = run(environment, command, ['--libs-only-L', packageName])
    const unsupportedLinkFlags = run(environment, command, ['--libs-only-other', packageName])

    if (!compileFlags.ok) {
      failures.push(`${command} --cflags: ${compileFlags.error}`)
      continue
    }
    if (!libraryFlags.ok) {
      failures.push(`${command} --libs-only-l: ${libraryFlags.error}`)
      continue
    }
    if (!searchFlags.ok) {
      failures.push(`${command} --libs-only-L: ${searchFlags.error}`)
      continue
    }
    if (!unsupportedLinkFlags.ok) {
      failures.push(`${command} --libs-only-other: ${unsupportedLinkFlags.error}`)
      continue
    }
    if (unsupportedLinkFlags.value !== '') {
      failures.push(
        `${command}: unsupported linker options ${unsupportedLinkFlags.value}; ` +
          'MoonBit semantic link configuration can only represent libraries and search paths',
      )
      continue
    }
    const discoveredLinkLibraries = flagValues(splitFlags(libraryFlags.value), '-l')
    if (discoveredLinkLibraries.length === 0) {
      failures.push(`${command} --libs-only-l: no link libraries`)
      continue
    }

    return {
      source: `pkg-config ${packageName} via ${command}`,
      compileFlags: compileFlags.value,
      libraries: discoveredLinkLibraries,
      libraryDirectories: uniquePaths(flagValues(splitFlags(searchFlags.value), '-L')),
    }
  }

  reject(
    context,
    `pkg-config ${packageName}`,
    failures.length === 0 ? 'no usable pkg-config result' : failures.join('; '),
  )
  return null
}

function resolveVcpkg(context, installLayout) {
  const { environment } = context
  const installedRoots = uniquePaths([
    environment.VCPKG_INSTALLED_DIR,
    environment.VCPKG_ROOT ? path.join(environment.VCPKG_ROOT, 'installed') : undefined,
  ]).filter(isDirectory)

  if (installedRoots.length === 0) {
    reject(context, 'vcpkg', 'no installed tree found')
    return null
  }

  const explicitTriplet = environment.VCPKG_TARGET_TRIPLET ?? environment.VCPKG_DEFAULT_TRIPLET

  if (explicitTriplet) {
    if (!tripletMatchesTarget(context, explicitTriplet)) {
      reject(
        context,
        'vcpkg',
        `explicit triplet ${explicitTriplet} does not match target ${[
          context.target.platform,
          context.target.architecture,
        ]
          .filter(Boolean)
          .join('/')}`,
      )
      return null
    }

    for (const installedRoot of installedRoots) {
      const prefix =
        path.basename(installedRoot) === explicitTriplet
          ? installedRoot
          : path.join(installedRoot, explicitTriplet)
      const dependency = resolveInstallPath(
        context,
        installLayout,
        `vcpkg ${explicitTriplet}`,
        prefix,
      )
      if (dependency != null) {
        return dependency
      }
    }
    reject(context, 'vcpkg', `explicit triplet ${explicitTriplet} is not usable`)
    return null
  }

  for (const installedRoot of installedRoots) {
    let entries
    try {
      entries = fs.readdirSync(installedRoot, { withFileTypes: true })
    } catch (error) {
      reject(
        context,
        `vcpkg ${installedRoot}`,
        error instanceof Error ? error.message : String(error),
      )
      continue
    }

    const matches = []
    for (const entry of entries) {
      if (!entry.isDirectory() || !tripletMatchesTarget(context, entry.name)) {
        continue
      }

      const dependency = resolveInstallPath(
        context,
        installLayout,
        `vcpkg ${entry.name}`,
        path.join(installedRoot, entry.name),
      )
      if (dependency != null) {
        matches.push({ triplet: entry.name, dependency })
      }
    }

    if (matches.length === 1) {
      return matches[0].dependency
    }
    if (matches.length > 1) {
      throw resolutionError(
        context,
        [
          `Found multiple compatible vcpkg triplets for ${context.config.packageName} under ${installedRoot}:`,
          ...matches.map((match) => `- ${match.triplet}`),
          'Set VCPKG_TARGET_TRIPLET to select one.',
        ].join('\n'),
      )
    }
  }

  reject(context, 'vcpkg', `no usable triplet for architecture ${context.target.architecture}`)
  return null
}

function tripletMatchesTarget(context, triplet) {
  const architecture = triplet.split('-')[0]
  if (
    architecture !== context.target.architecture &&
    architecture !== context.layout.architecture
  ) {
    return false
  }

  const parts = new Set(triplet.split('-').slice(1))
  const platforms = new Set([context.target.platform, context.layout.platform])
  if (isWindowsTarget(context)) {
    platforms.add('windows')
    platforms.add('mingw')
  } else if (context.target.platform === 'darwin' || context.layout.platform === 'macos') {
    platforms.add('osx')
  }

  return [...platforms].some((platform) => parts.has(platform))
}

function resolveCmakePrefixPath(context, installLayout) {
  const variable = 'CMAKE_PREFIX_PATH'
  const value = context.environment[variable]
  if (!value) {
    reject(context, variable, 'environment variable is not set')
    return null
  }

  for (const prefix of splitPathList(value)) {
    const dependency = resolveInstallPath(
      context,
      installLayout,
      `${variable} ${prefix}`,
      prefix,
    )
    if (dependency != null) {
      return dependency
    }
  }

  reject(context, variable, 'none of the configured prefixes is usable')
  return null
}

function resolveInstallPath(context, installLayout, source, installPath) {
  return resolvePaths(
    context,
    source,
    installLayout.includeDirectories(installPath, context.layout),
    installLayout.libraryDirectories(installPath, context.layout),
  )
}

function resolveToolchainSearchPaths(context) {
  const { environment } = context
  const includeDirs = isWindowsTarget(context)
    ? splitPathList(environment.INCLUDE)
    : [...splitPathList(environment.CPATH), ...splitPathList(environment.C_INCLUDE_PATH)]
  const libraryDirs = isWindowsTarget(context)
    ? splitPathList(environment.LIB)
    : splitPathList(environment.LIBRARY_PATH)
  const headerRoots = includeDirs.filter((directory) => hasHeaders(context, directory))

  if (headerRoots.length === 0) {
    reject(context, 'toolchain search paths', 'required headers were not found')
    return null
  }

  for (const includeDir of headerRoots) {
    const prefix = path.dirname(includeDir)
    const relatedLibraryDirs = libraryDirs.filter((directory) => isWithin(prefix, directory))
    if (relatedLibraryDirs.length === 0) {
      continue
    }

    const dependency = resolvePaths(
      context,
      `toolchain search paths under ${prefix}`,
      [includeDir],
      relatedLibraryDirs,
    )
    if (dependency != null) {
      return dependency
    }
  }

  reject(
    context,
    'toolchain search paths',
    'headers and library were not found under the same installation prefix',
  )
  return null
}

function resolvePaths(context, source, includeDirs, libraryDirs) {
  const normalizedIncludeDirs = uniquePaths(includeDirs)
  const normalizedLibraryDirs = uniquePaths(libraryDirs)
  const includeDirectory = normalizedIncludeDirs.find(
    (directory) => isDirectory(directory) && hasHeaders(context, directory),
  )
  if (includeDirectory == null) {
    reject(
      context,
      source,
      normalizedIncludeDirs.length === 0
        ? 'no include directories'
        : `missing ${context.config.headers.join(', ')}`,
    )
    return null
  }

  const existingLibraryDirs = normalizedLibraryDirs.filter(isDirectory)
  const libraryFile = findLibraryFile(context, existingLibraryDirs)
  if (libraryFile == null) {
    reject(
      context,
      source,
      existingLibraryDirs.length === 0
        ? 'no library directories'
        : `missing ${context.libraryFiles.join(', ')}`,
    )
    return null
  }

  return {
    source,
    includeDirectory,
    libraryFile,
    compileFlags: `-I${toFlagPath(includeDirectory)}`,
    libraries: [context.config.library.linkName],
    libraryDirectories: [path.dirname(libraryFile)],
  }
}

function hasHeaders(context, directory) {
  return context.config.headers.every((header) => isFile(path.join(directory, header)))
}

function findLibraryFile(context, libraryDirs) {
  for (const directory of libraryDirs) {
    for (const name of context.libraryFiles) {
      const file = path.join(directory, name)
      if (isFile(file)) {
        return file
      }
    }
  }

  return null
}

function run(environment, command, args) {
  let result
  try {
    result = spawnSync(command, args, {
      encoding: 'utf8',
      env: environment,
      windowsHide: true,
    })
  } catch (error) {
    return { ok: false, error: error instanceof Error ? error.message : String(error) }
  }

  if (result.error) {
    return { ok: false, error: result.error.message }
  }
  if (result.status !== 0) {
    const detail = result.stderr.trim()
    return {
      ok: false,
      error: detail === '' ? `exited with status ${result.status ?? 'unknown'}` : detail,
    }
  }

  return { ok: true, value: result.stdout.trim() }
}

function flagValues(flags, name) {
  const values = []

  for (let index = 0; index < flags.length; index += 1) {
    const flag = flags[index]
    if (flag === name && flags[index + 1] != null) {
      index += 1
      values.push(flags[index])
    } else if (flag.startsWith(name) && flag.length > name.length) {
      values.push(flag.slice(name.length))
    }
  }

  return values
}

function splitFlags(value) {
  const result = []
  let current = ''
  let quote

  for (let index = 0; index < value.length; index += 1) {
    const char = value[index]

    if (char === '\\' && (value[index + 1] === quote || /\s/.test(value[index + 1] ?? ''))) {
      index += 1
      current += value[index]
      continue
    }
    if (quote) {
      if (char === quote) {
        quote = undefined
      } else {
        current += char
      }
      continue
    }
    if (char === '"' || char === "'") {
      quote = char
    } else if (/\s/.test(char)) {
      if (current !== '') {
        result.push(current)
        current = ''
      }
    } else {
      current += char
    }
  }

  if (current !== '') {
    result.push(current)
  }

  return result
}

function splitPathList(value) {
  return value ? value.split(path.delimiter).filter(Boolean).map(resolvePath) : []
}

function uniquePaths(values) {
  const resolved = new Set()
  for (const value of values) {
    if (typeof value === 'string' && value !== '') {
      resolved.add(resolvePath(value))
    }
  }
  return [...resolved]
}

function resolvePath(value) {
  return path.resolve(unquote(value))
}

function unquote(value) {
  return value.length >= 2 && value[0] === value[value.length - 1] && /["']/.test(value[0])
    ? value.slice(1, -1)
    : value
}

function isWithin(parent, child) {
  const relative = path.relative(parent, child)
  return relative === '' || (!relative.startsWith('..') && !path.isAbsolute(relative))
}

function isWindowsTarget(context) {
  return context.target.platform === 'win32' || context.layout.platform === 'windows'
}

function isDirectory(value) {
  try {
    return fs.statSync(value).isDirectory()
  } catch {
    return false
  }
}

function isFile(value) {
  try {
    return fs.statSync(value).isFile()
  } catch {
    return false
  }
}

function reject(context, source, reason) {
  const message = `${source}: ${reason}`
  context.attempts.push(message)
  trace(context, `rejected ${message}`)
}

function trace(context, message) {
  if (context.debug) {
    console.error(`[native-dependency] ${message}`)
  }
}

function resolutionError(context, message) {
  return new Error(
    [
      message,
      context.attempts.length === 0
        ? undefined
        : ['Resolution attempts:', ...context.attempts.map((attempt) => `- ${attempt}`)].join('\n'),
      `Set ${debugVariable}=1 for detailed resolution diagnostics.`,
    ]
      .filter(Boolean)
      .join('\n'),
  )
}

function toFlagPath(value) {
  const normalized = value.replaceAll(path.sep, '/')
  return /\s/.test(normalized) ? `"${normalized.replaceAll('"', '\\"')}"` : normalized
}
