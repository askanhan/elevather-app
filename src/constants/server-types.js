export default class ServerTypes {
  constructor () {
    this.serverTypes = {
      leerlingen: 'LL',
      leerkrachten: 'PS',
      ouders: 'OUDERS'
    }
  }

  isLeerkrachtenWebsite (res) {
    return typeof res === 'string' && res.toUpperCase() === this.serverTypes.leerkrachten
  }

  isLeerlingenWebsite (res) {
    return typeof res === 'string' && res.toUpperCase() === this.serverTypes.leerlingen
  }

  isOudersWebsite (res) {
    return typeof res === 'string' && res.toUpperCase() === this.serverTypes.ouders
  }
}
