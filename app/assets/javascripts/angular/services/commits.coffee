app.service "Commits", ($http) ->
  this.yourLastClicked = null

  this.markAsReviewed = (commit, byEmail) ->
    $http.post("/commits/#{commit.id}/reviewed", email: byEmail)
    commit.reviewed = true
    commit.reviewer_email = byEmail

  this.markAsNew = (commit) ->
    $http.delete("/commits/#{commit.id}/unreviewed")
    commit.reviewed = false
    commit.reviewer_email = null

  this
