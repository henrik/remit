app.controller "CommitsCtrl", ($rootScope, $scope, $window, Commits) ->
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
    stats =
      allUnreviewed: 0
      youCanReview: 0

    for commit in $scope.commits
      if !commit.reviewed
        byYou     = $scope.authoredByYou(commit)

        stats.allUnreviewed += 1
        stats.youCanReview += 1 unless byYou

    stats.yourUnreviewed = stats.allUnreviewed - stats.youCanReview
    $scope.stats = stats
  , true

  $scope.markAsReviewed = (commit) ->
    Commits.markAsReviewed(commit, $scope.settings.email).
      error(reportServerError)

  $scope.markAsNew = (commit) ->
    Commits.markAsNew(commit).
      error(reportServerError)

  reportServerError = ->
    $window.alert("Server error! Your update may have been lost.")
