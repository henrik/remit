app.controller "CommentsCtrl", ($rootScope, $scope, $window, Settings, Comments) ->
  $rootScope.pageTitle = "Comments"

  $scope.isYourLastClicked = (comment) ->
    comment == Comments.yourLastClicked

  $scope.clicked = (comment) ->
    Comments.yourLastClicked = comment

  $scope.authoredByYou = (comment) ->
    $scope.settings.name and comment.authorName.indexOf($scope.settings.name) != -1

  $scope.onYourCommit = (commit) ->
    $scope.settings.name and commit and commit.authorName.indexOf($scope.settings.name) != -1

  $scope.saveSettings = ->
    Settings.save()

  $scope.markAsResolved = (comment, $event) ->
    stopEvent $event
    Comments.markAsResolved(comment, $scope.settings.email)

  $scope.markAsNew = (comment, $event) ->
    stopEvent $event
    Comments.markAsNew(comment, $scope.settings.email)

  # We have buttons nested within links, so we need this.
  stopEvent = ($event) ->
    $event.stopPropagation()
    $event.preventDefault()
