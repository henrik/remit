app.controller "CommitsCtrl", ($rootScope, $scope, $window, $location, Commits, CurrentUser) ->
  $rootScope.pageTitle = "Commits"

  $scope.isYourLastClicked = (commit) ->
    commit == Commits.yourLastClicked

  $scope.authoredByYou = (commit) ->
    $scope.settings.name and commit.authorName.indexOf($scope.settings.name) != -1

  $scope.jumpTo = (commit) ->
    # Scroll down
    $location.hash("commit-#{commit.id}")
    # Highlight
    Commits.yourLastClicked = commit
    # Navigate - that's the default event of the link.
    # We don't want to do it from JS to avoid popup blocker issues etc.

  $scope.clicked = (commit) ->
    Commits.yourLastClicked = commit

  $scope.startReview = (commit, $event) ->
    # If we already clicked the commit to show it in the other pane, and maybe started
    # writing a comment, we don't want to reload that pane when we start the review.
    # Or if we opened it in another tab, we don't want a second tab to open.
    stopEvent($event) if $scope.isYourLastClicked(commit)

    Commits.startReview(commit, CurrentUser.email)

  $scope.abandonReview = (commit, $event) ->
    stopEvent $event
    Commits.markAsNew(commit, CurrentUser.email)

  $scope.markAsReviewed = (commit, $event) ->
    stopEvent $event
    Commits.markAsReviewed(commit, CurrentUser.email)

  $scope.markAsNew = (commit, $event) ->
    stopEvent $event
    Commits.markAsNew(commit, CurrentUser.email)

  # We have buttons nested within links, so we need this.
  stopEvent = ($event) ->
    $event.stopPropagation()
    $event.preventDefault()
