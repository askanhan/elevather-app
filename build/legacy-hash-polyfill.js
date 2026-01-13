'use strict'
const crypto = require('crypto')

const legacyAlgorithms = new Set(['md4', 'MD4', 'ripemd160'])
const fallbackAlgorithm = 'sha256'

if (typeof crypto.__patchedForLegacyDigest !== 'boolean') {
  const originalCreateHash = crypto.createHash
  crypto.createHash = function patchedCreateHash (algorithm, options) {
    const resolvedAlgorithm = legacyAlgorithms.has(String(algorithm)) ? fallbackAlgorithm : algorithm
    return originalCreateHash.call(this, resolvedAlgorithm, options)
  }
  crypto.__patchedForLegacyDigest = true
}
