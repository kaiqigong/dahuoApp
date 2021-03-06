angular.module('starter', ['ionic', 'starter.controllers', 'starter.directives', 'starter.filters', 'starter.services', 'monospaced.elastic']).constant('configs', {
  baseUrl: 'http://dahuo.marry-me.today/'
}).config(function($httpProvider) {
  return $httpProvider.interceptors.push('urlInterceptor');
}).config(function($compileProvider) {
  return $compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|tel):/);
}).factory('urlInterceptor', function(configs) {
  return {
    request: function(config) {
      if (/^(|\/)(api|auth)/.test(config.url)) {
        config.url = configs.baseUrl + config.url;
      }
      return config;
    }
  };
}).run(function($ionicPlatform) {
  return $ionicPlatform.ready(function() {
    if (window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if (window.StatusBar) {
      return StatusBar.styleDefault();
    }
  });
}).config(function($stateProvider, $urlRouterProvider) {
  $stateProvider.state('app', {
    url: '/app',
    abstract: true,
    templateUrl: 'templates/menu.html',
    controller: 'AppCtrl'
  }).state('app.main', {
    url: '/main',
    views: {
      menuContent: {
        templateUrl: 'templates/main.html',
        controller: 'EaterylistCtrl'
      }
    }
  }).state('app.eateryDetail', {
    url: '/eatery/:eateryId',
    views: {
      menuContent: {
        templateUrl: 'templates/eaterydetail.html',
        controller: 'EaterydetailCtrl'
      }
    }
  }).state('app.chief', {
    url: '/chief',
    abstract: true,
    views: {
      menuContent: {
        templateUrl: 'templates/chief.html',
        controller: 'ChiefHomeCtrl'
      }
    }
  }).state('app.chief.home', {
    url: '',
    templateUrl: 'templates/chief-home.html'
  }).state('app.chief.comments', {
    url: '/comments',
    templateUrl: 'templates/chief-comments.html'
  }).state('app.chief.schedules', {
    url: '/schedules',
    templateUrl: 'templates/chief-schedules.html'
  }).state('app.search', {
    url: '/search',
    views: {
      menuContent: {
        templateUrl: 'templates/search.html'
      }
    }
  }).state('app.browse', {
    url: '/browse',
    views: {
      menuContent: {
        templateUrl: 'templates/browse.html'
      }
    }
  }).state('app.playlists', {
    url: '/playlists',
    views: {
      menuContent: {
        templateUrl: 'templates/playlists.html',
        controller: 'PlaylistsCtrl'
      }
    }
  }).state('app.single', {
    url: '/playlists/:playlistId',
    views: {
      menuContent: {
        templateUrl: 'templates/playlist.html',
        controller: 'PlaylistCtrl'
      }
    }
  });
  return $urlRouterProvider.otherwise('/app/main');
});
