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

app.controller "FluidAppInfoCtrl", ($scope, FluidApp) ->
  $scope.inFluidApp = FluidApp.running
