app.service "FluidApp", ($location) ->
  # Check for a URL query string param like "?app=true".
  # Would like to use $window.fluid but Browsa panes don't see that.
  this.running = !!$location.search().app
