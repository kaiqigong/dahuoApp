angular.module 'starter.services', []

.factory 'Camera', ($q, $window)->
  cameraMock =
    getPicture: (success)->
      # todo: pase base64 str
      result = $window.prompt('mock camera called for web test, please eanter a valid image url','/img/ionic.png')
      # '/img/ionic.png'
      success?(result)

  getPicture: (options) ->
    q = $q.defer()
    navigator.camera ?= cameraMock
    navigator.camera?.getPicture (result) ->
      # Do any magic you need
      q.resolve(result)
    , (err) ->
      q.reject(err)
    , options
    q.promise
