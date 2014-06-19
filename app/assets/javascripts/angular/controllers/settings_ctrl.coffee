app.controller "SettingsCtrl", ($rootScope, $scope, Settings) ->
  $rootScope.pageTitle = "Settings"

  $scope.save = ->
    Settings.save()
