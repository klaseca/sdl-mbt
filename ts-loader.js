import { registerHooks, stripTypeScriptTypes } from 'node:module'

import { readFileSync } from 'node:fs'
import { fileURLToPath } from 'node:url'

const TS_IN_NODE_MODULES = /[\\/]node_modules[\\/].*\.ts$/

registerHooks({
  load(url, context, nextLoad) {
    const filename = url.startsWith('file:') && fileURLToPath(url)

    if (filename && TS_IN_NODE_MODULES.test(filename)) {
      return {
        format: 'module',
        source: stripTypeScriptTypes(readFileSync(filename, 'utf8'), { sourceUrl: url }),
        shortCircuit: true,
      }
    }

    return nextLoad(url, context)
  },
})
