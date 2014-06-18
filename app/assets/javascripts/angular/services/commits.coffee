app.service "Commits", ($http) ->
  this.yourLastClicked = null

  this.markAsReviewed = (commit, byEmail) ->
    promise = $http.post("/commits/#{commit.id}/reviewed", email: byEmail)
    commit.reviewed = true
    commit.reviewer_email = byEmail
    promise

  this.markAsNew = (commit) ->
    promise = $http.delete("/commits/#{commit.id}/unreviewed")
    commit.reviewed = false
    commit.reviewer_email = null
    promise

  this
