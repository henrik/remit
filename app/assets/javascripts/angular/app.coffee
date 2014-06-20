window.app = angular.module "Remit", [
  "ngRoute"
  "ngAnimate"
  "doowb.angular-pusher"
  "ui.gravatar"
  "ipCookie"
  "angularMoment"
]

app.run ($rootScope, $location, Settings) ->
  $rootScope.settings = Settings.load
    include_my_comments: false
    include_comments_on_others: true

  $rootScope.navClass = (path) ->
    "current" if $location.path() == path
