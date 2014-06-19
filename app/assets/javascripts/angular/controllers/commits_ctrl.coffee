app.controller "CommitsCtrl", ($rootScope, $scope, $window, Commits, CommitStats) ->
  $rootScope.pageTitle = "Commits"

  $scope.isYourLastClicked = (commit) ->
    commit == Commits.yourLastClicked

  $scope.authoredByYou = (commit) ->
    $scope.settings.name and commit.author_name.indexOf($scope.settings.name) != -1

  $scope.clicked = (commit) ->
    Commits.yourLastClicked = commit

  # Only run this calculation once for every update of this
  # collection (including property changes within).
  $scope.$watch "commits", ->
    $scope.stats = CommitStats.stats($scope.commits, $scope.settings.name)
  , true

  $scope.markAsReviewed = (commit) ->
    Commits.markAsReviewed(commit, $scope.settings.email).
      error(reportServerError)

  $scope.markAsNew = (commit) ->
    Commits.markAsNew(commit).
      error(reportServerError)

  reportServerError = ->
    $window.alert("Server error! Your update may have been lost.")
