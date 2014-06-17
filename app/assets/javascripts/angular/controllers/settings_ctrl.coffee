app.controller "SettingsCtrl", ($rootScope, $scope, localStorageService) ->
  $rootScope.pageTitle = "Settings"

  $scope.save = ->
    localStorageService.set("email", $scope.settings.email)
    localStorageService.set("name", $scope.settings.name)
