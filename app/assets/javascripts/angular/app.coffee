window.app = angular.module("Remit", [ "ngRoute", "ui.gravatar", "emoji" ])

angular.module("ui.gravatar").config (gravatarServiceProvider) ->
    gravatarServiceProvider.secure = true  # https
    gravatarServiceProvider.defaults =
      size: 40
