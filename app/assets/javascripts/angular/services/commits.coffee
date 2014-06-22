app.service "Commits", ($http) ->
  this.yourLastClicked = null

  this.markAsReviewed = (commit, byEmail) ->
    promise = $http.post("/commits/#{commit.id}/reviewed", email: byEmail)
    commit.isReviewed = true
    commit.reviewerEmail = byEmail
    promise

  this.markAsNew = (commit) ->
    promise = $http.delete("/commits/#{commit.id}/unreviewed")
    commit.isReviewed = false
    commit.reviewerEmail = null
    promise

  this
