angular.module('starter.controllers', [])

.controller 'AppCtrl', ($scope, $ionicModal, $timeout) ->
  $scope.menuItems = [
    {
      name: 'app.main'
      title: '我是吃货'
    }
    {
      name: 'app.chief'
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


.controller 'EaterydetailCtrl', ($scope, $http, $state)->
  s = $scope
  angular.extend s,
    eatery: undefined

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
        s.eatery = eatery

  s.getEatery()


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
