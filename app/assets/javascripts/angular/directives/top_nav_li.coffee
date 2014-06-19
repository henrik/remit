app.directive "topNavLink", ($location) ->
  restrict: "A"
  transclude: true
  template: "<a href={{href}}><span ng-transclude></span></a>"
  scope:
    href: "@topNavLink"
  link: (scope, element, attrs) ->
    scope.location = $location
    scope.$watch "location.path()", (path) ->
      if path == scope.href
        element.addClass("current")
      else
        element.removeClass("current")
