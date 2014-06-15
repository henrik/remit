app.service "Commits", ($http) ->
  this.yourLastClicked = null

  this.markAsReviewed = (commit) ->
    $http.post("/commits/#{commit.id}/reviewed")
    commit.reviewed = true

  this.markAsNew = (commit) ->
    $http.delete("/commits/#{commit.id}/unreviewed")
    commit.reviewed = false

  this

app.service "FluidApp", ($window) ->
  # Check for a URL query string param like "?app=true".
  # Can't use $location; that looks for params in the hashbang.
  # Would like to use $window.fluid but Browsa panes don't see that.
  this.running = !!$window.location.search.match(/[&?]app=[^&]/)
