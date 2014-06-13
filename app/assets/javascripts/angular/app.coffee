window.app = angular.module("Remit", [ "ngRoute", "ui.gravatar", "emoji" ])

app.run ($rootScope, $location) ->
  $rootScope.navClass = (path) ->
    "current" if $location.path() == path


angular.module("ui.gravatar").config (gravatarServiceProvider) ->
    gravatarServiceProvider.secure = true  # https
    gravatarServiceProvider.defaults =
      size: 40
