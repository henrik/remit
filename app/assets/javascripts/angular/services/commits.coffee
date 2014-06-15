app.service "Commits", ($http) ->
  this.yourLastClicked = null

  this.markAsReviewed = (commit) ->
    $http.post("/commits/#{commit.id}/reviewed")
    commit.reviewed = true

  this.markAsNew = (commit) ->
    $http.delete("/commits/#{commit.id}/unreviewed")
    commit.reviewed = false

  this
