# Use target="_blank" outside Fluid.app so you don't exit Remit.
# But inside Fluid.app, having a target messes up the pane handling.

angular.module("Remit").directive "fluidAppLink", (FluidApp) ->
  link: (scope, element, attrs) ->
    unless FluidApp.running
      element.attr("target", "_blank")
