app.service "Commits", ($http) ->
  this.yourLastClicked = null

  this.markAsReviewed = (commit, byEmail) ->
    promise = $http.post("/commits/#{commit.id}/reviewed", email: byEmail)
    commit.reviewed = true
    commit.reviewerEmail = byEmail
    promise

  this.markAsNew = (commit) ->
    promise = $http.delete("/commits/#{commit.id}/unreviewed")
    commit.reviewed = false
    commit.reviewerEmail = null
    promise

  this
