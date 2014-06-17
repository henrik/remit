app.controller "SettingsCtrl", ($rootScope, $scope, localStorageService) ->
  $rootScope.pageTitle = "Settings"

  $scope.settings =
    email: localStorageService.get("email")
    name: localStorageService.get("name")

  $scope.save = ->
    localStorageService.set("email", $scope.settings.email)
    localStorageService.set("name", $scope.settings.name)
