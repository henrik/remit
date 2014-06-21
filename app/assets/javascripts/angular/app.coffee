window.app = angular.module "Remit", [
  "ngRoute"
  "ngAnimate"
  "doowb.angular-pusher"
  "ui.gravatar"
  "ipCookie"
  "once"
]

app.run ($rootScope, Settings) ->
  $rootScope.settings = Settings.load
    include_my_comments: false
    include_comments_on_others: true
