app.controller "CommitsCtrl", ($rootScope, $scope, $window, Commits) ->
  $rootScope.pageTitle = "Commits"

  $scope.isYourLastClicked = (commit) ->
    commit == Commits.yourLastClicked

  $scope.authoredByYou = (commit) ->
    $scope.settings.name and commit.authorName.indexOf($scope.settings.name) != -1

  $scope.clicked = (commit) ->
    Commits.yourLastClicked = commit

  $scope.startReview = (commit, $event) ->
    # If we already clicked the commit to show it in the other pane, and maybe started
    # writing a comment, we don't want to reload that pane when we start the review.
    # Or if we opened it in another tab, we don't want a second tab to open.
    stopEvent($event) if $scope.isYourLastClicked(commit)

    Commits.startReview(commit, $scope.settings.email).
      error(reportServerError)

  $scope.abandonReview = (commit, $event) ->
    stopEvent $event
    Commits.markAsNew(commit).
      error(reportServerError)

  $scope.markAsReviewed = (commit, $event) ->
    stopEvent $event
    Commits.markAsReviewed(commit, $scope.settings.email).
      error(reportServerError)

  $scope.markAsNew = (commit, $event) ->
    stopEvent $event
    Commits.markAsNew(commit).
      error(reportServerError)

  # We have buttons nested within links, so we need this.
  stopEvent = ($event) ->
    $event.stopPropagation()
    $event.preventDefault()

  reportServerError = ->
    $window.alert("Server error! Your update may have been lost.")
