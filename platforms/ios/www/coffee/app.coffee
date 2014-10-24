# Ionic Starter App

# angular.module is a global place for creating, registering and retrieving Angular modules
# 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
# the 2nd parameter is an array of 'requires'
# 'starter.controllers' is found in controllers.js
angular.module 'starter', [
  'ionic'
  'starter.controllers'
  'starter.directives'
  'starter.filters'
  'starter.services'
  'monospaced.elastic'
]
.constant 'configs',
  baseUrl: 'http://dahuo.marry-me.today/'
.config ($httpProvider) ->
  $httpProvider.interceptors.push 'urlInterceptor'

.config ($compileProvider)->
  $compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|tel):/)

.factory 'urlInterceptor', (configs) ->
  # Add authorization token to headers
  request: (config) ->
    config.url = configs.baseUrl + config.url if /^(|\/)(api|auth)/.test config.url
    config

.run ($ionicPlatform) ->
  $ionicPlatform.ready ->
    # Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    # for form inputs)
    if window.cordova && window.cordova.plugins.Keyboard
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar true
    if window.StatusBar
      # org.apache.cordova.statusbar required
      StatusBar.styleDefault()

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
  .state 'app',
    url: '/app',
    abstract: true,
    templateUrl: 'templates/menu.html',
    controller: 'AppCtrl'

  .state 'app.main',
    url: '/main'
    views:
      menuContent :
        templateUrl: 'templates/main.html'
        controller: 'EaterylistCtrl'

  .state 'app.eateryDetail',
    url: '/eatery/:eateryId'
    views:
      menuContent :
        templateUrl: 'templates/eaterydetail.html'
        controller: 'EaterydetailCtrl'

  .state 'app.chief',
    url: '/chief'
    abstract: true
    views:
      menuContent :
        templateUrl: 'templates/chief.html'
        controller: 'ChiefHomeCtrl'

  .state 'app.chief.home',
    url: ''
    templateUrl: 'templates/chief-home.html'

  .state 'app.chief.comments',
    url: '/comments'
    templateUrl: 'templates/chief-comments.html'

  .state 'app.chief.schedules',
    url: '/schedules'
    templateUrl: 'templates/chief-schedules.html'

  .state 'app.search',
    url: '/search',
    views:
      menuContent :
        templateUrl: 'templates/search.html'

  .state 'app.browse',
    url: '/browse',
    views:
      menuContent :
        templateUrl: 'templates/browse.html'

  .state 'app.playlists',
    url: '/playlists',
    views:
      menuContent :
        templateUrl: 'templates/playlists.html',
        controller: 'PlaylistsCtrl'

  .state 'app.single',
    url: '/playlists/:playlistId',
    views:
      menuContent :
        templateUrl: 'templates/playlist.html',
        controller: 'PlaylistCtrl'

  # if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise '/app/main'
