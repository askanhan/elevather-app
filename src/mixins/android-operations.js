import axios from 'axios'

import * as globalMutationTypes from '@/store/mutation-types.js'
import bao from '@/mixins/basic-operations.js'
const basicOperations = bao.methods

export default {
  methods: {
    _openFileExternalMobileDevice(doc) {
      var dit = this
      window.requestFileSystem(window.TEMPORARY, 5 * 1024 * 1024, function (fs) {
        dit._getCurrentFile(fs.root, doc);
      }, dit._onErrorLoadFs);
    },
    _onErrorLoadFs() {
      this.$store.commit(globalMutationTypes.SHOW_MESSAGE, ['_onErrorLoadFs', 'error'], {
        root: true
      })
    },
    _getCurrentFile(dirEntry, doc) {
      var dit = this
      dit.$store.commit(globalMutationTypes.LOCK_SCREEN)
      axios({
        method: 'get',
        url: doc.documentUrl,
        responseType: 'blob'
      }).then(function (response) {
        dit.$store.commit(globalMutationTypes.UNLOCK_SCREEN)
        console.log('bestand opgehaald als BLOB')
        var blob = response.data
        var fileName = doc.D_NAAM
        blob.lastModifiedDate = new Date();
        blob.name = fileName;
        dit._saveFile(dirEntry, blob, fileName, doc);
      }).catch(function (res) {
        dit.$store.commit(globalMutationTypes.UNLOCK_SCREEN)
        dit._errorGetBlobFileFromFilemanager(res.message)
      })

    },

    _errorGetBlobFileFromFilemanager(response) {
      this.$store.commit(globalMutationTypes.SHOW_MESSAGE, ['Ophalen bestand mislukt : ' + response, 'error'], {
        root: true
      })
    },

    _saveFile(dirEntry, fileData, fileName, doc) {
      var dit = this
      dirEntry.getFile(fileName, {
        create: true,
        exclusive: false
      }, function (fileEntry) {
        dit._writeFile(fileEntry, fileData, doc);
      }, dit._onErrorCreateFile);
    },
    _onErrorCreateFile() {
      this.$store.commit(globalMutationTypes.SHOW_MESSAGE, ['_onErrorCreateFile', 'error'], {
        root: true
      })
    },
    _writeFile(fileEntry, dataObj, doc) {
      var dit = this
      // Create a FileWriter object for our FileEntry (log.txt).
      fileEntry.createWriter(function (fileWriter) {
        fileWriter.onwriteend = function () {
          console.log("Successful file write...");
          if (dataObj.type.indexOf('image') > -1) {
            dit._readBinaryFile(fileEntry, dataObj, doc);
          } else {
            dit._readFile(fileEntry, dataObj, doc);
          }

        };
        fileWriter.onerror = function (e) {
          console.log("Failed file write: " + e.toString());
        };
        fileWriter.write(dataObj);
      });
    },
    _readFile(fileEntry, dataObj, doc) {
      var dit = this
      fileEntry.file(function (file) {
        var reader = new FileReader();
        reader.onloadend = function () {
          console.log("Successful file read: " + this.result);
          dit._displayFileData(fileEntry.fullPath + ": " + this.result);
          dit._openFile(fileEntry, dataObj)
        };
        reader.readAsText(file);
      }, dit._onErrorReadFile);
    },
    _onErrorReadFile() {
      this.$store.commit(globalMutationTypes.SHOW_MESSAGE, ['_onErrorReadFile', 'error'], {
        root: true
      })
    },
    _readBinaryFile(fileEntry, dataObj, doc) {
      var dit = this
      fileEntry.file(function (file) {
        var reader = new FileReader();
        reader.onloadend = function () {
          console.log("Successful file write: " + this.result);
          dit._displayFileData(fileEntry.fullPath + ": " + this.result);
          var blob = new Blob([new Uint8Array(this.result)], {
            type: "image/png"
          });
          //dit._displayImage(blob, doc);
          dit._displayImageByFileURL(fileEntry, doc);
          dit._openFile(fileEntry, dataObj)
        };
        reader.readAsArrayBuffer(file);
      }, dit._onErrorReadBinaryFile);
    },
    _onErrorReadBinaryFile() {
      this.$store.commit(globalMutationTypes.SHOW_MESSAGE, ['_onErrorReadBinaryFile', 'error'], {
        root: true
      })
    },

    _openFile(fileEntry, dataObj) {
      var MIME = 'onbekend'
      if (!(basicOperations._isEmpty(dataObj))) {
        MIME = dataObj.type
      }
      cordova.plugins.fileOpener2.showOpenWithDialog(
        fileEntry.nativeURL, // bv. HUAWEI P20 Pro\Interne opslag\Android\data\be.schoolware.app\cache
        MIME, {
          error: function (e) {
            console.log('Error status: ' + e.status + ' - Error message: ' + e.message);
          },
          success: function () {
            console.log('file opened successfully');
          }
        }
      );
    },
    _displayFileData(data) {
      console.log(data);
    },
    _displayImage(blob, doc, fileEntry) {
      // Displays image if result is a valid DOM string for an image.
      var elem = document.getElementById('myImage');
      // Note: Use window.URL.revokeObjectURL when finished with image.
      elem.src = window.URL.createObjectURL(blob); // werkt!
    },
    _displayImageByFileURL(fileEntry, doc) {
      /*var elem = document.getElementById('myImage');
      elem.src = fileEntry.toURL();*/
      doc.docThumbnail = fileEntry.toURL();
      this.callback(doc);
    },



    _takePictureMobileDevice() {
      console.log('_takePicture')
      var permissions = cordova.plugins.permissions;
      var dit = this
      permissions.requestPermission(permissions.READ_EXTERNAL_STORAGE,
        function (status) {
          if (!status.hasPermission)
            dit._errorExternalStorage(dit);
          else
            permissions.requestPermission(permissions.CAMERA, dit._successExternalStorage.bind(dit),
              dit._errorCamera);
        }, dit._errorExternalStorage);
    },
    _successExternalStorage(status) {
      if (!status.hasPermission)
        this._errorExternalStorage();
      else
        this._openCamera();
    },
    _errorExternalStorage() {
      this.$store.commit(globalMutationTypes.SHOW_MESSAGE, ['READ_EXTERNAL_STORAGE permission niet actief', 'error'], {
        root: true
      })
    },
    _errorCamera() {
      this.$store.commit(globalMutationTypes.SHOW_MESSAGE, ['CAMERA permissie niet actief', 'error'], {
        root: true
      })
    },
    _openCamera() {
      navigator.camera.getPicture(this._onSuccessGetPicture, this._onFailGetPicture, {
        quality: 25,
        // eslint-disable-next-line
        destinationType: Camera.DestinationType.DATA_URL // FILE_URI vs DATA_URL
      });
    },
    _onSuccessGetPicture( /*fileURI */ imageData) {
      var timestap = new Date().getTime()
      var newPicture = document.getElementById('newPhotoThumbnail'); // DATA_URL
      newPicture.name = 'Foto-' + timestap
      newPicture.src = "data:image/jpeg;base64," + imageData;
      var block = newPicture.src.split(";");
      var contentType = block[0].split(":")[1];
      var realData = block[1].split(",")[1];
      var blob = this._b64toBlob(realData, contentType);
      blob.name = newPicture.name + '.jpg'
      navigator.camera.cleanup()
      this.callback(blob)
      // this._getFileEntry(fileURI, dit) niet relevant
    },
    _onFailGetPicture(message) {
      this.$store.commit(globalMutationTypes.SHOW_MESSAGE, ['Fout _onSuccessGetPicture:' + message, 'error'], {
        root: true
      })
      navigator.camera.cleanup()
    },
    _b64toBlob(b64Data, contentType, sliceSize) {
      contentType = contentType || '';
      sliceSize = sliceSize || 512;
      var byteCharacters = atob(b64Data);
      var byteArrays = [];
      for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
        var slice = byteCharacters.slice(offset, offset + sliceSize);
        var byteNumbers = new Array(slice.length);
        for (var i = 0; i < slice.length; i++) {
          byteNumbers[i] = slice.charCodeAt(i);
        }
        var byteArray = new Uint8Array(byteNumbers);
        byteArrays.push(byteArray);
      }
      var blob = new Blob(byteArrays, {
        type: contentType
      });
      return blob;
    },
    _fileSelectMobileDevice() {
      var source = navigator.camera.PictureSourceType.PHOTOLIBRARY;
      var dit = this
      navigator.camera.getPicture(dit._onSuccessFileSelectAndroid, dit._onFailFileSelectAndroid, {
        quality: 25,
        // DATA_URL base64 image string
        // FILE_URI Android path
        // NATIVE_URI iOS path
        // eslint-disable-next-line
        destinationType: Camera.DestinationType.DATA_URL,
        sourceType: source,
        mediaType: navigator.camera.MediaType.ALLMEDIA
        /*allowEdit: false,
        encodingType: Camera.EncodingType.JPEG,
        destinationType: Camera.DestinationType.DATA_URL,
        sourceType: Camera.PictureSourceType.CAMERA,
        targetWidth: 320,
        targetHeight: 240*/
      });
    },
    _onSuccessFileSelectAndroid(fileURI) {
      var dit = this
      var dezeFileURI = fileURI
      axios({
        method: 'get',
        url: fileURI,
        responseType: 'blob'
      }).then(function (response) {
        console.log('bestand opgehaald als BLOB')
        var blob = response.data
        var fileName = dezeFileURI.substr(dezeFileURI.lastIndexOf('/') + 1);
        blob.name = fileName
        dit.callback(blob)
        /*
        Effectief inlezen momenteel niet nodig
        var reader = new FileReader();
        reader.readAsDataURL(blob);
        reader.onloadend = function () {
          var base64data = reader.result;)
        }*/

      })
    },
    _onFailFileSelectAndroid(message) {
      this.$store.commit(globalMutationTypes.SHOW_MESSAGE, ['Fout _onFailFileSelectAndroid:' + message, 'error'], {
        root: true
      })
    }
  }

}
