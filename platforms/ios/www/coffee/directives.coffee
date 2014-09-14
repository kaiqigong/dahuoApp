angular.module 'starter.directives', []

.directive 'directiveName', () ->
  restrict: 'E'
  template: '<div>directiveName</div>'
  link: (scope, iElement, iAttrs) ->

.directive 'srcKey', ()->
  restrict: 'A'
  scope:
    srcKey:'='
    suffix:'@'
    srcAttr:'@'

  link: ($scope, $element, $attrs) ->
    setSource = (url)->
      switch $scope.srcAttr
        when 'background-image'
          $element.css('background-image','url(' + url + ')')
        when 'data'
          $element[0].data = url
        else
          $element[0].src = url

    $scope.$watch 'srcKey',(key) ->
      if !key or key is ''
        return
      # key start with //, http, / should be a relative or absolute path
      else if /^(\/\/|\/|http:|https:)/.test(key)
        setSource(key)
      else
        suffix = $scope.suffix ? ''
        setSource('http://dahuo.qiniudn.com/'+ key + suffix)

.directive 'eateryCard', ()->
  restrict: 'A'
  scope:
    eatery: '='
  templateUrl: 'templates/eatery-card.html'
