app.controller "SettingsCtrl", ($rootScope, $scope, Settings) ->
  $rootScope.pageTitle = "Settings"

  $scope.exampleAuthor = ->
    $scope.settings.name || "Charles Babbage"

  $scope.save = ->
    Settings.save()
