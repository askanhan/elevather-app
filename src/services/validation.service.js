export default class ValidationService {
  isString (str) {
    return typeof str === 'string'
  }
  isRijksregisternummer (n) {
    n = n.split('_').join('')
    n = n.split('-').join('')
    n = n.split('.').join('')
    if (!this.isString(n)) {
      return [false, 'Rijksregisternummer is niet ingevuld']
    }

    if (n.length !== 11) {
      return [false, 'Rijksregisternummer moet 11 karakters lang zijn']
    }

    let checkDigit = n.substr(n.length - 2, 2)
    let modFunction = function (nr) {
      return 97 - (nr % 97)
    }
    let nrToCheck = parseInt(n.substr(0, 9))

    // first check without 2
    if (modFunction(nrToCheck) + '' == checkDigit) { // eslint-disable-line
      return [true, '']
    }

    // then check with 2 appended for y2k+ births
    nrToCheck = parseInt('2' + n.substr(0, 9))

    if (modFunction(nrToCheck) + '' !== checkDigit) {
      return [false, 'Ongeldig rijksregisternummer']
    }
    return [true, '']
  }

  isStraat (n) {
    if (!this.isString(n)) {
      return [false, 'Straat is niet ingevuld']
    }
    if (n.length < 2) {
      return [false, 'Straat moet minstens 2 karakters lang zijn']
    }
    return [true, '']
  }

  isHuisnummer (n) {
    if (!this.isString(n)) {
      return [false, 'Huisnummer is niet ingevuld']
    }
    if (n.length < 2) {
      return [false, 'Huisnummer moet minstens 1 karakters lang zijn']
    }
    return [true, '']
  }

  isGemeente (n) {
    if (!this.isString(n)) {
      return [false, 'Gemeente is niet ingevuld']
    }
    if (n.length < 2) {
      return [false, 'Gemeente moet minstens 2 karakters lang zijn']
    }
    return [true, '']
  }

  isPostcode (n) {
    if (!this.isString(n)) {
      return [false, 'Postcode is niet ingevuld']
    }
    if (n.length !== 4) {
      return [false, 'Postcode moet 4 karakters lang zijn']
    }
    return [true, '']
  }

  isGemeenteRecord (n) {
    if (n === null || n.ID === undefined || n.ID === null || n.ID < 0) {
      return [false, 'Gemeente is niet ingevuld']
    }
    return [true, '']
  }

  isTelefoon (n) {
    n = n.split('_').join('')
    n = n.split('/').join('')
    n = n.split('.').join('')
    if (!this.isString(n)) {
      return [false, 'Telefoonnummer is niet ingevuld']
    }
    if (n.length !== 9) {
      return [false, 'Telefoonnummer moet 9 karakters lang zijn']
    }
    return [true, '']
  }

  isGSM (n) {
    n = n.split('_').join('')
    n = n.split('/').join('')
    n = n.split('.').join('')
    if (!this.isString(n)) {
      return [false, 'GSM nummer is niet ingevuld']
    }
    if (n.length !== 10) {
      return [false, 'GSM nummer moet 10 karakters lang zijn']
    }
    return [true, '']
  }

  validateEmail (email) {
    /*eslint-disable */
    let re =
      /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    /* eslint-enable */
    return re.test(email)
  }

  isEmail (n) {
    if (!this.isString(n)) {
      return [false, 'Emailadres is niet ingevuld']
    }
    if (n.length < 4) {
      return [false, 'Emailadres moet minstens 3 karakters lang zijn']
    }
    if (!this.validateEmail(n)) {
      return [false, 'Gelieve een geldig emailadres op te geven']
    }
    return [true, '']
  }

  isGeboortedatum (n) {
    n = n.split('_').join('')
    n = n.split('/').join('')
    if (!this.isString(n)) {
      return [false, 'Geboortedatum is niet ingevuld']
    }
    if (n.length !== 8) {
      return [false, 'Geboortedatum moet 8 karakters lang zijn']
    }
    return [true, '']
  }
  isNaam (name) {
    if (!this.isString(name)) {
      return [false, 'Naam is niet ingevuld']
    }
    if (name.length < 2) {
      return [false, 'Naam moet minstens 2 karakters lang zijn']
    }
    if (name.length > 64) {
      return [false, 'Naam mag niet langer zijn dan 64 karakters']
    }
    return [true, '']
  }
  isVoornaam (name) {
    if (!this.isString(name)) {
      return [false, 'Voornaam is niet ingevuld']
    }
    if (name.length < 2) {
      return [false, 'Voornaam moet minstens 2 karakters lang zijn']
    }
    if (name.length > 64) {
      return [false, 'Voornaam mag niet langer zijn dan 64 karakters']
    }
    return [true, '']
  }
  isConnectionName (name) {
    if (!this.isString(name)) {
      return [false, 'Naam connectie is niet ingevuld']
    }
    if (name.length < 2) {
      return [false, 'Naam connectie moet minstens 2 karakters lang zijn']
    }
    if (name.length > 64) {
      return [false, 'Naam connectie mag niet langer zijn dan 64 karakters']
    }
    return [true, '']
  }
  isUsername (name) {
    if (!this.isString(name)) {
      return [false, 'Gebruikersnaam is niet ingevuld']
    }
    if (name.length < 2) {
      return [false, 'Gebruikersnaam moet minstens 2 karakters lang zijn']
    }
    if (name.length > 64) {
      return [false, 'Gebruikersnaam mag niet langer zijn dan 64 karakters']
    }
    return [true, '']
  }
  isPassword (pwd) {
    if (!this.isString(pwd)) {
      return [false, 'Wachtwoord is niet ingevuld']
    }
    if (pwd.length < 2) {
      return [false, 'Wachtwoord moet minstens 2 karakters lang zijn']
    }
    if (pwd.length > 64) {
      return [false, 'Wachtwoord mag niet langer zijn dan 64 karakters']
    }
    return [true, '']
  }
  isServerLocation (name) {
    if (!this.isString(name)) {
      return [false, 'Server locatie is niet ingevuld']
    }
    if (name.length > 255) {
      return [false, 'Server locatie mag niet langer zijn dan 1024 karakters']
    }
    name = name.toLowerCase()
    if (name.indexOf('https://') !== 0 && name.indexOf('http://') !== 0 && name.indexOf('www.') !== 0) {
      return [false, "Server locatie moet beginnen 'http', 'https' of 'www' "]
    }
    return [true, '']
  }
}
