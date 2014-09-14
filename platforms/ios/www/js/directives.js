angular.module('starter.directives', []).directive('directiveName', function() {
  return {
    restrict: 'E',
    template: '<div>directiveName</div>',
    link: function(scope, iElement, iAttrs) {}
  };
}).directive('srcKey', function() {
  return {
    restrict: 'A',
    scope: {
      srcKey: '=',
      suffix: '@',
      srcAttr: '@'
    },
    link: function($scope, $element, $attrs) {
      var setSource;
      setSource = function(url) {
        switch ($scope.srcAttr) {
          case 'background-image':
            return $element.css('background-image', 'url(' + url + ')');
          case 'data':
            return $element[0].data = url;
          default:
            return $element[0].src = url;
        }
      };
      return $scope.$watch('srcKey', function(key) {
        var suffix, _ref;
        if (!key || key === '') {

        } else if (/^(\/\/|\/|http:|https:)/.test(key)) {
          return setSource(key);
        } else {
          suffix = (_ref = $scope.suffix) != null ? _ref : '';
          return setSource('http://dahuo.qiniudn.com/' + key + suffix);
        }
      });
    }
  };
}).directive('eateryCard', function() {
  return {
    restrict: 'A',
    scope: {
      eatery: '='
    },
    templateUrl: 'templates/eatery-card.html'
  };
});
