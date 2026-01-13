/* global module */
module.exports = {
  methods: {
    _hexToR(h) {
      return parseInt((this._cutHex(h)).substring(0, 2), 16)
    },
    _hexToG(h) {
      return parseInt((this._cutHex(h)).substring(2, 4), 16)
    },
    _hexToB(h) {
      return parseInt((this._cutHex(h)).substring(4, 6), 16)
    },
    _cutHex(h) {
      return (h.charAt(0) === '#') ? h.substring(1, 7) : h
    },
    _rgbToDecimal(r, g, b) {
      return (r << 16) + (g << 8) + (b)
    },
    _hexToRgb(hex) {
      // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
      let shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i
      hex = hex.replace(shorthandRegex, function (m, r, g, b) {
        return r + r + g + g + b + b
      })

      let result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
      return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
      } : null
    },
    _changeColorToRGB(kleurCode) {
      if (kleurCode !== undefined && kleurCode[0] !== undefined) {
        let colorInteger = kleurCode[0].Extra
        return this._changeColorToRGBWithInteger(colorInteger)
      }
    },
    _changeColorToRGBWithInteger(integer) {
      let color = this._convertColor(integer)
      if (color[0] !== undefined && color[1] !== undefined && color[2] !== undefined) {
        return 'background-color:rgba(' + color[2] + ',' + color[1] + ',' + color[0] + ',1);'
      }
    },
    _convertColor(decimal) {
      if (decimal !== undefined && decimal > -1) {
        let hexString = this._pad(decimal.toString(16), 6)
        let R = this._hexToR(hexString)
        let G = this._hexToG(hexString)
        let B = this._hexToB(hexString)
        return [R, G, B]
      } else {
        return ['255', '255', '255'] // wit
      }
    },
    _dec2bin(dec) {
      return (dec >>> 0).toString(2)
    },
    _bin2dec(bin) {
      return parseInt(bin, 2)
    },
    _getRGBForDecimalColorNumber(decimalColorNumber) {
      if (decimalColorNumber < 0) {
        return 'rgb(255,255,255)'
      } else if (decimalColorNumber === 0 || decimalColorNumber === '0') {
        return 'rgb(0,0,0)'
      }
      let _bin = self.dec2bin(decimalColorNumber)
      let b = 0
      let g = 0
      let r = 0
      // starts with RED
      r = _bin.slice(-8)
      _bin = _bin.slice(0, -8)
      if (_bin !== '') {
        g = _bin.slice(-8)
        _bin = _bin.slice(0, -8)
        if (_bin !== '') {
          b = _bin.slice(-8)
        }
      }
      return 'rgb(' + self.bin2dec(r) + ',' + self.bin2dec(g) + ',' + self.bin2dec(b) + ')'
    },
    _b64EncodeUnicode(str) {
      return btoa(encodeURIComponent(str).replace(/%([0-9A-F]{2})/g,
        function toSolidBytes(match, p1) {
          return String.fromCharCode('0x' + p1)
        }))
    },
    _b64DecodeUnicode(str) {
      return decodeURIComponent(atob(str).split('').map(function (c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2)
      }).join(''))
    },
    _changeColorToHEX(kleurCode) {
      if (kleurCode !== undefined) {
        let colorInteger = kleurCode.Extra
        return this._changeColorToHEXWithInteger(colorInteger)
      }
    },
    _changeColorToHEXWithInteger(integer) {
      let color = this._convertColorToHex(integer)
      if (color !== undefined) {
        return color
      }
    },
    _convertColorToHex(decimal) {
      if (decimal !== undefined && decimal > -1) {
        let hexString = this._pad(decimal.toString(16), 6)
        let R = this._hexToR(hexString)
        let G = this._hexToG(hexString)
        let B = this._hexToB(hexString)
        let color = this._rgb2hex(B, G, R)
        return color
      } else {
        return '#FFFFFF'
      }
    },
    _pad(num, size) {
      let s = num + ''
      while (s.length < size) s = '0' + s
      return s
    },
    _rgb2hex(red, green, blue) {
      let rgb = blue | (green << 8) | (red << 16)
      let color = '#' + (0x1000000 + rgb).toString(16).slice(1)
      return color
    }
  }
}
