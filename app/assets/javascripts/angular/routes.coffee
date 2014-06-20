app.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)

  $routeProvider.
    when("/",
      redirectTo: "/commits"
    ).
    when("/commits",
      templateUrl: "commits.html"
      controller: "CommitsCtrl"
    ).
    when("/comments",
      templateUrl: "comments.html"
      controller: "CommentsCtrl"
    ).
    when("/settings",
      templateUrl: "settings.html"
      controller: "SettingsCtrl"
    )
