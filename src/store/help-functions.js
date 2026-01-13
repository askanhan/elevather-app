export default class HelpFunctions {
  createConnectionObject (connection, connectionTypes) {
    connection.ID = new Date().getTime()
    connection.connectionTypes = connectionTypes
    connection.connectionType = connectionTypes.filter(function (c) {
      return c._selected
    })[0]
    return connection
  }

  editConnectionObject (connection, connectionTypes) {
    connection.connectionTypes = connectionTypes
    connection.connectionType = connectionTypes.filter(function (c) {
      return c._selected
    })[0]
    return connection
  }

  foutmeldingMaken (res) {
    return 'Error code ' + res.status + ' : ' + res.message
  }
}
