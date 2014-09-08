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

.controller 'EaterylistCtrl', ($scope, $http)->
  s = $scope
  angular.extend s,
    eateries: undefined

    getEateries: ()->
      $http.get 'api/eateries'
      .success (eateries)->
        s.eateries = eateries

  s.getEateries()

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
