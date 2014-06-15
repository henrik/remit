app.service "FluidApp", ($window) ->
  # Check for a URL query string param like "?app=true".
  # Can't use $location; that looks for params in the hashbang.
  # Would like to use $window.fluid but Browsa panes don't see that.
  this.running = !!$window.location.search.match(/[&?]app=[^&]/)
