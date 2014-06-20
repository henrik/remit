app.controller "CommentsCtrl", ($rootScope, $scope, Settings) ->
  $rootScope.pageTitle = "Comments"

  $scope.authoredByYou = (comment) ->
    $scope.settings.name and comment.author_name.indexOf($scope.settings.name) != -1

  $scope.onYourCommit = (commit) ->
    $scope.settings.name and commit and commit.author_name.indexOf($scope.settings.name) != -1

  $scope.saveSettings = ->
    Settings.save()
