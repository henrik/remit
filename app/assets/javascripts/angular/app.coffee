window.app = angular.module("Remit", [ "ngRoute", "ui.gravatar", "emoji" ])

app.run ($rootScope, $location) ->
  $rootScope.currentPage = (path) ->
    $location.path() == path


angular.module("ui.gravatar").config (gravatarServiceProvider) ->
    gravatarServiceProvider.secure = true  # https
    gravatarServiceProvider.defaults =
      size: 40
