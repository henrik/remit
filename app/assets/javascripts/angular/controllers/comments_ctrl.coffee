app.controller "CommentsCtrl", ($rootScope, $scope, Settings, Comments) ->
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
