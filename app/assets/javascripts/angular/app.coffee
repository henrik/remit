window.app = angular.module "Remit", [
  "ngRoute"
  "ngAnimate"
  "doowb.angular-pusher"
  "ui.gravatar"
  "ipCookie"
  "angularMoment"
]

app.run ($rootScope, $location, Settings) ->
  $rootScope.settings = Settings.load()

  $rootScope.navClass = (path) ->
    "current" if $location.path() == path
