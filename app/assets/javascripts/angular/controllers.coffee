app.controller "HomeCtrl", ($rootScope, $scope) ->
  $rootScope.pageTitle = "Remit"
  $scope.name = "world"

app.controller "CommitsCtrl", ($rootScope, $scope) ->
  $rootScope.pageTitle = "Commits"

app.controller "CommentsCtrl", ($rootScope, $scope) ->
  $rootScope.pageTitle = "Comments"
