app.controller "CommentsCtrl", ($rootScope, $scope) ->
  $rootScope.pageTitle = "Comments"

  $scope.authoredByYou = (comment) ->
    $scope.settings.name and comment.author_name.indexOf($scope.settings.name) != -1
