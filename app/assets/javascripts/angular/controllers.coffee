app.controller "CommitsCtrl", ($rootScope, $scope, Commits, localStorageService) ->
  $rootScope.pageTitle = "Commits"

  $scope.yourName = localStorageService.get("name")

  $scope.isYourLastClicked = (commit) ->
    commit == Commits.yourLastClicked

  $scope.authoredByYou = (commit) ->
    $scope.yourName and commit.author_name.indexOf($scope.yourName) != -1

  $scope.clicked = (commit) ->
    Commits.yourLastClicked = commit

  $scope.markAsReviewed = (commit) ->
    Commits.markAsReviewed(commit)

  $scope.markAsNew = (commit) ->
    Commits.markAsNew(commit)

app.controller "CommentsCtrl", ($rootScope, $scope) ->
  $rootScope.pageTitle = "Comments"

app.controller "SettingsCtrl", ($rootScope, $scope, localStorageService) ->
  $rootScope.pageTitle = "Settings"

  $scope.settings =
    name: localStorageService.get("name")

  $scope.save = ->
    localStorageService.set("name", $scope.settings.name)

app.controller "FluidAppInfoCtrl", ($scope, FluidApp) ->
  $scope.inFluidApp = FluidApp.running
