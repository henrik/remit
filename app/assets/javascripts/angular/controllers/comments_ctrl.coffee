app.controller "CommentsCtrl", ($rootScope, $scope, $window, Settings, CurrentUser, Comments) ->
  $rootScope.pageTitle = "Comments"

  $scope.isYourLastClicked = (comment) ->
    comment == Comments.yourLastClicked

  $scope.clicked = (comment) ->
    Comments.yourLastClicked = comment

  $scope.authoredByYou = (comment) ->
    CurrentUser.isAuthorOf(comment)

  $scope.onYourCommit = (commit) ->
    commit and CurrentUser.isAuthorOf(commit)

  $scope.saveSettings = ->
    Settings.save()

  $scope.markAsResolved = (comment, $event) ->
    stopEvent $event
    Comments.markAsResolved(comment, CurrentUser.email)

  $scope.markAsNew = (comment, $event) ->
    stopEvent $event
    Comments.markAsNew(comment, CurrentUser.email)

  # We have buttons nested within links, so we need this.
  stopEvent = ($event) ->
    $event.stopPropagation()
    $event.preventDefault()
