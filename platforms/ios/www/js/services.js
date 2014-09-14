angular.module('starter.services', []).factory('Camera', function($q, $window) {
  var cameraMock;
  cameraMock = {
    getPicture: function(success) {
      var result;
      result = $window.prompt('mock camera called for web test, please eanter a valid image url', '/img/ionic.png');
      return typeof success === "function" ? success(result) : void 0;
    }
  };
  return {
    getPicture: function(options) {
      var q, _ref;
      q = $q.defer();
      if (navigator.camera == null) {
        navigator.camera = cameraMock;
      }
      if ((_ref = navigator.camera) != null) {
        _ref.getPicture(function(result) {
          return q.resolve(result);
        }, function(err) {
          return q.reject(err);
        }, options);
      }
      return q.promise;
    }
  };
});
