app.service "Commits", ($http) ->
  this.yourLastClicked = null

  # We're optimistically changing local values until the request completes and updates
  # the entities again (as it has done for everyone but the person who made the change).

  this.startReview = (commit, byEmail) ->
    promise = $http.post("/commits/#{commit.id}/started_review", email: byEmail)
    commit.isNew = false
    commit.isBeingReviewed = true
    commit.pendingReviewerEmail = byEmail
    promise

  this.markAsReviewed = (commit, byEmail) ->
    promise = $http.post("/commits/#{commit.id}/reviewed", email: byEmail)
    commit.isBeingReviewed = false
    commit.isReviewed = true
    commit.reviewerEmail = byEmail
    promise

  this.markAsNew = (commit) ->
    promise = $http.delete("/commits/#{commit.id}/unreviewed")
    commit.isBeingReviewed = false
    commit.isReviewed = false
    commit.isNew = true
    commit.reviewerEmail = null
    promise

  this
