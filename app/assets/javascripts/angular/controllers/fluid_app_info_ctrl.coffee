app.controller "FluidAppInfoCtrl", ($scope, FluidApp) ->
  $scope.inFluidApp = FluidApp.running
