app.service "FluidApp", ($window) ->
  # Check the user agent.
  # Cannot check $window.fluid since Browsa panes don't have that.
  this.running = $window.navigator.userAgent.indexOf("FluidApp") != -1
