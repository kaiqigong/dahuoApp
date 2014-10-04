angular.module('starter.controllers', [])

.controller 'AppCtrl', ($scope, $ionicModal, $timeout) ->
  $scope.menuItems = [
    {
      name: 'app.main'
      title: '我是吃货'
    }
    {
      name: 'app.chiefHome'
      title: '我是大厨'
    }
  ]
  # Form data for the login modal
  $scope.loginData = {}
  # Create the login modal that we will use later
  $ionicModal.fromTemplateUrl('templates/login.html', {
    scope: $scope
  }).then (modal) ->
    $scope.modal = modal

  # Triggered in the login modal to close it
  $scope.closeLogin = () ->
    $scope.modal.hide()

  # Open the login modal
  $scope.login = () ->
    $scope.modal.show()

  # Perform the login action when the user submits the login form
  $scope.doLogin = () ->
    console.log('Doing login', $scope.loginData)

    # Simulate a login delay. Remove this and replace with your login
    # code if using a login system
    $timeout(() ->
      $scope.closeLogin()
    , 1000)

.controller 'EaterylistCtrl', ($scope, $http, $state)->
  s = $scope
  angular.extend s,
    eateries: undefined

    getEateries: ()->
      $http.get 'api/eateries'
      .success (eateries)->
        eateries.forEach (eatery)->
          eatery.likes = 12
          eatery.eats = 20
          eatery.$shifts = [{'time': '今天19:00',capacity: 5, orders: [1,2,3],price: 20},
          {'time': '明天19:00',capacity: 5, orders: [1,2],price: 20},
          {'time': '9月4号19:00',capacity: 5, orders: [1,2,3,4,5]},
          {'time': '11月10号19:00',capacity: 5, orders: [1,2,3,4]},price: 20]
          eatery.$shift = eatery.$shifts[0]
        s.eateries = eateries

    viewEateryDetail: (eatery)->
      $state.go('app.eateryDetail', {eateryId: eatery._id})

    onJoin: ($event, eatery)->
      $event.stopPropagation()
      # Goto payment page

  s.getEateries()


.controller 'EaterydetailCtrl', ($scope, $http, $state, $ionicScrollDelegate)->
  s = $scope
  angular.extend s,
    eatery: undefined

    newComment: {}

    getEatery: ()->
      $http.get 'api/eateries/' + $state.params.eateryId
      .success (eatery)->
        eatery.likes = 12
        eatery.eats = 20
        eatery.$shifts = [{'time': '今天19:00',capacity: 5, orders: [1,2,3],price: 20},
        {'time': '明天19:00',capacity: 5, orders: [1,2],price: 30},
        {'time': '9月4号19:00',capacity: 5, orders: [1,2,3,4,5],price: 20},
        {'time': '11月10号19:00',capacity: 5, orders: [1,2,3,4]},price: 20]
        eatery.$shift = eatery.$shifts[0]
        eatery.$comments = [
          {
            content: '很好吃'
          }
          {
            content: '女主人很漂亮'
          }
        ]
        s.eatery = eatery

    toggleCollect: ()->
      @eatery.$collected = !@eatery.$collected
      # todo: impl

    gotoComments: ()->
      # todo: goto comments view.
      $ionicScrollDelegate.scrollBottom true

    sendComment: ()->
      @eatery.$comments.push angular.copy(@newComment)
      @newComment.content = ''


  s.getEatery()

.controller 'ChiefHomeCtrl', ($scope, $http, $ionicScrollDelegate, Camera)->
  s = $scope
  angular.extend s,
    eatery: undefined

    oldEatery:undefined

    newComment: {}

    getMyEatery: ()->
      $http.get 'api/eateries?own=true'
      .success (eateries)->
        # get the first eatery detail
        $http.get 'api/eateries/' + eateries[0]._id
        .success (data)->
          angular.extend s.eatery, data

        eatery = eateries[0]
        eatery.likes = 12
        eatery.eats = 20
        eatery.$shifts = [{'time': '今天19:00',capacity: 5, orders: [1,2,3],price: 20},
        {'time': '明天19:00',capacity: 5, orders: [1,2],price: 30},
        {'time': '9月4号19:00',capacity: 5, orders: [1,2,3,4,5],price: 20},
        {'time': '11月10号19:00',capacity: 5, orders: [1,2,3,4]},price: 20]
        eatery.$shift = eatery.$shifts[0]
        eatery.$comments = [
          {
            content: '很好吃'
          }
          {
            content: '女主人很漂亮'
          }
        ]
        s.oldEatery = angular.copy(eatery)
        s.eatery = eatery

    toggleCollect: ()->
      @eatery.$collected = !@eatery.$collected
      # todo: impl

    gotoComments: ()->
      # todo: goto comments view.
      $ionicScrollDelegate.scrollBottom true

    sendComment: ()->
      @eatery.$comments.push angular.copy(@newComment)
      @newComment.content = ''

    getPhoto: ()->
      Camera.getPicture()
      .then (imageURI) ->
        s.eatery.$newImage = imageURI
        # post to server and get remote url
        s.eatery.background = s.eatery.$newImage
        # save eatery
        $http.put 'api/eateries/' + s.eatery._id, {background: s.eatery.background}
      , (err) ->
        console.err err
      , {
        quality: 75,
        targetWidth: 320,
        targetHeight: 320,
        saveToPhotoAlbum: true
        destinationType: navigator.camera.DestinationType.FILE_URI
      }


    changeDishPhoto: (dish)->
      Camera.getPicture()
      .then (imageURI) ->
        dish.image = imageURI
        # save eatery
        $http.put 'api/dishes/' + dish._id, {image: imageURI}
      , (err) ->
        console.err err
      , {
        quality: 75,
        targetWidth: 320,
        targetHeight: 320,
        saveToPhotoAlbum: true
        destinationType: navigator.camera.DestinationType.FILE_URI
      }

    saveDish: (dish)->
      $http.put 'api/dishes/' + dish._id, dish
      .success (data)->
        angular.extend dish, data

    patchEatery: (field)->
      patch = {}
      patch[field] = @eatery[field]
      if patch[field] is @oldEatery[field]
        # not changed
        return
      $http.put 'api/eateries/' + s.eatery._id, patch
      .success (eatery)->
        $scope.eatery._v = eatery._v
        angular.extend $scope.oldEatery, $scope.eatery

    deleteDish: (dish)->
      $http.delete 'api/dishes/' + dish._id
      .success ()->
        s.eatery.dishes.splice(s.eatery.dishes.indexOf(dish), 1)
        $http.put 'api/eateries/' + s.eatery._id, {dishes: s.eatery.dishes.map (i)-> i._id}
        .success (eatery)->
          $scope.eatery._v = eatery._v
          angular.extend $scope.oldEatery, $scope.eatery

    addDish: ()->
      $http.post 'api/dishes'
      .success (data)->
        s.eatery.dishes.push data
        $http.put 'api/eateries/' + s.eatery._id, {dishes: s.eatery.dishes.map (i)-> i._id}
        .success (eatery)->
          $scope.eatery._v = eatery._v
          angular.extend $scope.oldEatery, $scope.eatery

  s.getMyEatery()


.controller 'PlaylistsCtrl', ($scope) ->
  $scope.playlists = [
    { title: 'Reggae', id: 1 },
    { title: 'Chill', id: 2 },
    { title: 'Dubstep', id: 3 },
    { title: 'Indie', id: 4 },
    { title: 'Rap', id: 5 },
    { title: 'Motel', id: 6 }
  ]

.controller 'PlaylistCtrl', ($scope, $stateParams) ->
