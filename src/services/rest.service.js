import store from '@/store/index.js'
import * as mutationTypes from '@/store/mutation-types.js'
import bao from '@/mixins/basic-operations.js'
const basicOperations = bao.methods

import axios from 'axios'
let instance = null // singleton
export default class RestService {
  constructor() {
    if (!instance) {
      instance = this
    }
    this.globalTypes = mutationTypes
    let self = this

    this.sendMutation = function (mutationName, params) {
      store.commit(mutationName, params)
    }

    // should be called before using any function of rest.service.js
    // @connection (object) which contains the details of logged in user
    // @screenLockingFunctionEnabled sets the screen locking functionality
    // for 2 purposes:
    // (1) to save the connection in order to re-login after receiving 401 unauthorized error
    // (2) to set the baseUrl of axios in order to use only relative urls in all queries

    // this._initialize = function (connection, API, screenLockingFunctionEnabled = true) {
    //   this.loggedInConnection = connection
    //   this.screenLockingFunctionEnabled = screenLockingFunctionEnabled
    //   this.originalAPI = API
    //   let baseUrl = connection.serverLocation
    //   /* instance.baseURL = baseUrl + 'bin/server.fcgi/REST/'; */
    //   let axiosDefaults = require('axios/lib/defaults')
    //   axiosDefaults.baseURL = baseUrl + 'bin/server.fcgi/' + API + '/'
    // }

    this.lockScreenIfNeeded = function (lockScreen) {
      if (typeof lockScreen === 'undefined' && store.state.flags.lockScreenForEachQueries) {
        this.sendMutation(this.globalTypes.LOCK_SCREEN)
      } else if (lockScreen) {
        this.sendMutation(this.globalTypes.LOCK_SCREEN)
      }
    }

    this.unlockScreenIfNeeded = function () {
      if (store.state.flags.lockScreenForEachQueries || store.state.flags.screenLocked) {
        this.sendMutation(this.globalTypes.UNLOCK_SCREEN)
      }
    }

    this.beforeSendQuery = function (lockScreen) {
      lockScreen && this.lockScreenIfNeeded(lockScreen)
    }

    this.afterSendQuery = function () {
      this.unlockScreenIfNeeded()
    }

    /*
    The following functions are used to send the correspondent queries from outside of this class
    */
    this.GET = function (url, params, successFunction, errorFunction, lockScreen = true, timeout, API = 'REST') {
      this.beforeSendQuery(lockScreen)
      this.queryExecuter(3, 'GET', url, params, undefined, successFunction, errorFunction, timeout, API)
    }

    this.POST = function (url, data, successFunction, errorFunction, lockScreen = true, timeout, API = 'REST') {
      this.beforeSendQuery(lockScreen)
      this.queryExecuter(3, 'POST', url, undefined, data, successFunction, errorFunction, timeout, API)
    }

    this.PUT = function (url, data, successFunction, errorFunction, lockScreen = true, timeout, API = 'REST') {
      this.beforeSendQuery(lockScreen)
      url = data.ID ? url + '/' + data.ID : url
      this.queryExecuter(3, 'PUT', url, undefined, data, successFunction, errorFunction, timeout, API)
    }

    this.DELETE = function (url, data, successFunction, errorFunction, lockScreen = true, timeout, API = 'REST') {
      this.beforeSendQuery(lockScreen)
      url = data && data.ID ? url + '/' + data.ID : url
      this.queryExecuter(3, 'DELETE', url, undefined, data, successFunction, errorFunction, timeout, API)
    }

    this.EXECUTE_CONCURRENT = function (method, params, successFunction, errorFunction, lockScreen = true, timeout, API = 'REST') {
      this.beforeSendQuery(lockScreen)
      this.runArrayOfPromises(method, 3, params, successFunction, errorFunction, timeout, API) // createPromises
    }

    this.EXECUTE_CONCURRENT_WITH_CUSTOM_METHODS = function (params, successFunction, errorFunction, lockScreen = true, timeout, API = 'REST') {
      this.beforeSendQuery(lockScreen)
      this.runArrayOfPromises('custom', 3, params, successFunction, errorFunction, timeout, API) // createCustomPromises
    }

    this.createPromises = function (method, params, timeout, API) {
      let promises = []
      for (let i = 0; i < params.length; i++) {
        let url = params[i].resource
        delete params[i].resource
        promises.push(this.execute(method, url, method === 'GET' ? params[i].parameters : undefined, method === 'GET' ? undefined : params[i]
          .parameters,
          timeout, API))
      }
      return promises
    }

    this.createCustomPromises = function (params, timeout, API) {
      let promises = []
      for (let i = 0; i < params.length; i++) {
        let url = params[i].resource
        let method = params[i].method
        let usedAPI = typeof params[i].api === 'undefined' ? API : params[i].api
        // Workaround om POSTen van bv. meerdere WisaAanwezigAPI.VerwerkAanwezigHeden
        if (params[i].methodAanroep !== undefined) {
          params[i].method = params[i].methodAanroep
          if (usedAPI === 'REST') { // meerdere REST inserts:
            delete params[i].action
            delete params[i].method
            delete params[i].type
            delete params[i].tid
            delete params[i].data
            params[i] = params[i].parameters
            if (method === 'PUT' || method === 'DELETE') {
              url = url + '/' + params[i].ID
            }
          }
          delete params[i].methodAanroep
          delete params[i].api
          delete params[i].resource
        }
        let parameters = params[i].parameters
        let externalServer = params[i].externalServer
        let noParamsDirectURL = params[i].noParamsDirectURL
        let typeResource = params[i].typeResource
        promises.push(this.execute(method, url, method === 'GET' ? parameters : undefined, method === 'GET' ? undefined : params[i], timeout,
          usedAPI, externalServer, noParamsDirectURL, typeResource))
      }
      return promises
    }

    this.runArrayOfPromises = function (type, nOfRetries, params, successFunction, errorFunction, timeout, API = 'REST') {
      let promises = []
      if (type === 'custom') {
        promises = this.createCustomPromises(params, timeout, API)
      } else { // then type= method type like GET, DEL etc.
        promises = this.createPromises(type, params, timeout, API)
      }

      let latterSuccessFunction = response => {
        instance.afterSendQuery()
        if (typeof successFunction !== 'undefined') {
          successFunction(response)
        }
      }

      let lattererrorFunction = (response) => {
        instance.afterSendQuery() //        afterSendQuery ???
        nOfRetries--
        if (nOfRetries >= -5 && typeof response !== 'undefined' && response.response !== undefined && response.response.status === 401) {
          store.dispatch({
            type: 'login',
            connection: store.state.userInfo.loggedInConnectionObject,
            successCallback: function () {
              setTimeout(function () {
                instance.runArrayOfPromises(type, nOfRetries, params, successFunction, errorFunction, timeout, API)
              }, 2000)
            }
          })
        } else {
          if (typeof errorFunction !== 'undefined') {
            errorFunction(response)
          }
        }
      }
      // successFunction is made equal to genericSuccessFunction if undefined
      successFunction = successFunction || this.genericSuccessFunction
      // errorFunction is made equal to genericErrorFunction if undefined
      errorFunction = errorFunction || this.genericErrorFunction
      if (nOfRetries >= 0) {
        var axiosVisible = axios
        if (params !== undefined && params[0] !== undefined && params[0].externalServer !== undefined && params[0].externalServer.indexOf('katholiekonderwijs.vlaanderen') > -1) {
          axiosVisible.defaults.headers.get['Authorization'] = 'Basic ' + btoa(unescape(encodeURIComponent(sessionStorage.getItem('VUE_LLINKID_USERNAME') + ':' + sessionStorage.getItem('VUE_LLINKID_PASSWORD'))));
        }
        axiosVisible.all(promises).then(latterSuccessFunction).catch(function (res) {
          lattererrorFunction(res, promises)
        })
      }
    }

    // callback function which will be called
    // if the query failed and if there is no errorFunction defined
    // since it is not decided what to do after failed query
    // this genericErrorFunction is expected to show the message to the user
    this.genericErrorFunction = function (response) {
      // algemeen alert of toasting service to show the error
      let message = ''
      if (response.message !== undefined) {
        message = response.message
      } else {
        message = response.response.data.message
      }
      // self.sendMutation(self.globalTypes.SHOW_MESSAGE, [message, 'error'])
      console.error('--------------------')
      console.error('REST SERVICE ERROR')
      console.error(message)
      console.error('--------------------')
      // basicOperations._showMessage('test')
      instance.afterSendQuery()
    }

    // callback function which will be called
    // if the query succeeded and if there is no successFunction defined
    this.genericSuccessFunction = function (response) {
      // do nothing
      instance.afterSendQuery()
    }

    // the loop function which calls the original execute method with correspondent parameters and
    // can be called multiple times after failing the query with 401 unauthorized error
    // @nOfRetries (integer) stands for number of times the loop can go further
    // @methodName (string) name of the query method
    // @url (string) relative url (or resource name in practice)
    // @params (object) set of filters to be applied on query
    // @data (object) set of data to be sent op queries POST, PUT and DELETE
    // @successFunction (function) success callback function given by the caller
    // @errorFunction (function) error callback function given by the caller
    // @timeout (integer) timeout value given by the caller
    this.queryExecuter = function (nOfRetries, methodName, url, params, data, successFunction, errorFunction, timeout, API) {
      // successFunction is made equal to genericSuccessFunction if undefined
      successFunction = successFunction || this.genericSuccessFunction
      // errorFunction is made equal to genericErrorFunction if undefined
      errorFunction = errorFunction || this.genericErrorFunction
      // success function to be used during the loop
      // in order to arrange loading-related functionality
      let latterSuccessFunction = response => {
        instance.afterSendQuery()
        successFunction(response)
      }
      // error function to be used during the loop
      // if the status of response is 401 (unauthorized)
      // it calls login action in order to re-login
      // and call the original method again
      // if nOfRetries is still positive
      let latterErrorFunction = (response) => {
        instance.afterSendQuery()
        nOfRetries--
        if (nOfRetries > 0 && typeof response !== 'undefined' && response.response !== undefined && response.response.status === 401) {
          // login is required
          store.dispatch({
            type: 'login',
            connection: store.state.userInfo.loggedInConnectionObject,
            successCallback: function () {
              console.log('hi from normal latterErrorFunction')
              console.log(nOfRetries, methodName, url, params, data, successFunction, errorFunction, timeout, API)
              instance.queryExecuter(nOfRetries, methodName, url, params, data, successFunction, errorFunction, timeout, API)
            }
          })
        } else {
          // otherwise calls the original errorFunction (or genericErrorFunction)
          errorFunction(response)
        }
      }
      // the actually call happens here
      if (nOfRetries > 0) {
        this.execute(methodName, url, params, data, timeout, API).then(latterSuccessFunction).catch(latterErrorFunction)
      }
    }

    // This is the only function that communicates with the server
    // @method (string) stands for the method of to be sent query
    // @url (string) will be concatenated to the baseURL, so relative, in other words, the resource to be used in server
    // @params (object) that contains filters and parameters of the query
    // @data (object) that contains the data for the queries PUT, DELETE and POST
    // @timeout is default 15 second, which can be changed if given in a specific query
    // _dc parameter is always sent to avoid caching in browsers
    this.execute = function (method, url, params, data, timeout = 15000, API, externalServer, noParamsDirectURL, typeResource) {
      var serverLocation = store.state.serverLocation
      if (!(_.isEmpty(externalServer))) {
        serverLocation = externalServer
      }
      if (!(_.isEmpty(noParamsDirectURL))) {
        url = noParamsDirectURL
        params = null
      }
      if (!(_.isEmpty(typeResource))) {
        params = typeResource
      }
      var request = {
        _dc: new Date().getTime(),
        method: method,
        url: url.startsWith('http') ? url : serverLocation + '/' + url,
        params: params,
        data: data
      }
      console.log(store.state)
      if (store.state.flags.loggedIn) {
        request.headers = {
          Authorization: 'Bearer ' + store.state.token
        }
      }
      if (url && (url.indexOf('/Update') > -1) || (url.indexOf('/Insert') > -1) || (url.indexOf('/Delete') > -1)) {
        var bodyFormData = new FormData();
        bodyFormData.set('rows', JSON.stringify(data.rows))
        request.data = bodyFormData
      }

      return axios(request)
    }
  }
}
