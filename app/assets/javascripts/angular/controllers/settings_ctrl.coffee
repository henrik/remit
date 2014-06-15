app.controller "SettingsCtrl", ($rootScope, $scope, localStorageService) ->
  $rootScope.pageTitle = "Settings"

  $scope.settings =
    name: localStorageService.get("name")

  $scope.save = ->
    localStorageService.set("name", $scope.settings.name)
