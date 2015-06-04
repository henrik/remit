app.controller "CommentsCtrl", ($rootScope, $scope, $window, Settings, Comments) ->
  $rootScope.pageTitle = "Comments"

  $scope.isYourLastClicked = (comment) ->
    comment == Comments.yourLastClicked

  $scope.clicked = (comment) ->
    Comments.yourLastClicked = comment

  $scope.authoredByYou = (comment) ->
    isAuthoredByYou(comment)

  $scope.onYourCommit = (commit) ->
    isAuthoredByYou(commit)

  $scope.onYourComment = (comment) ->
    return false unless $scope.settings.name
    return false if isAuthoredByYou(comment)

    yourCommentsOnTheSameThread = (c for c in $scope.comments when (
        c.threadIdentifier == comment.threadIdentifier and isAuthoredByYou(c)
      )
    )
    yourCommentsOnTheSameThread.length > 0

  $scope.saveSettings = ->
    Settings.save()

  $scope.markAsResolved = (comment, $event) ->
    stopEvent $event
    Comments.markAsResolved(comment, $scope.settings.email)

  $scope.markAsNew = (comment, $event) ->
    stopEvent $event
    Comments.markAsNew(comment, $scope.settings.email)

  isAuthoredByYou = (record) ->
    $scope.settings.name and record and record.authorName.indexOf($scope.settings.name) != -1

  # We have buttons nested within links, so we need this.
  stopEvent = ($event) ->
    $event.stopPropagation()
    $event.preventDefault()
