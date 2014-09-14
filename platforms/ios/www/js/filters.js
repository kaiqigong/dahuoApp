angular.module('starter.filters', []).filter('htmlToPlaintext', function() {
  return function(input) {
    return String(input).replace(/<[^>]+>/gm, '');
  };
});
