app.controller "CommitsCtrl", ($rootScope, $scope, Commits) ->
  $rootScope.pageTitle = "Commits"

  $scope.isYourLastClicked = (commit) ->
    commit == Commits.yourLastClicked

  $scope.authoredByYou = (commit) ->
    $scope.settings.name and commit.author_name.indexOf($scope.settings.name) != -1

  $scope.clicked = (commit) ->
    Commits.yourLastClicked = commit

  $scope.markAsReviewed = (commit) ->
    Commits.markAsReviewed(commit, $scope.settings.email)

  $scope.markAsNew = (commit) ->
    Commits.markAsNew(commit)
