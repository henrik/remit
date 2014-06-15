app.controller "CommitsCtrl", ($rootScope, $scope, Commits) ->
  $rootScope.pageTitle = "Commits"

  $scope.isYourLastClicked = (commit) ->
    commit == Commits.yourLastClicked

  $scope.clicked = (commit) ->
    Commits.yourLastClicked = commit

app.controller "CommentsCtrl", ($rootScope, $scope) ->
  $rootScope.pageTitle = "Comments"

app.controller "SettingsCtrl", ($rootScope, $scope) ->
  $rootScope.pageTitle = "Settings"

app.controller "FluidAppCtrl", ($scope, $window) ->
  # Check for a URL query string param like "?app=true".
  # Can't use $location; that looks for params in the hashbang.
  $scope.inFluidApp = $window.location.search.match(/[&?]app=[^&]/)
