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
