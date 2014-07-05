app.service "Commits", ($http, ErrorReporter) ->
  this.yourLastClicked = null

  # We're optimistically changing local values for the reviewer.
  # The HTTP requests changes them server-side and notifies others.
  # The notifications are ignored for the reviewer to avoid flickering
  # if a notification arrives AFTER the next optimistic state change.

  this.startReview = (commit, byEmail) ->
    $http.post("/commits/#{commit.id}/started_review", email: byEmail).
      error(ErrorReporter.reportServerError)

    commit.isNew = false
    commit.isBeingReviewed = true
    commit.pendingReviewerEmail = byEmail

  this.markAsReviewed = (commit, byEmail) ->
    $http.post("/commits/#{commit.id}/reviewed", email: byEmail).
      error(ErrorReporter.reportServerError)

    commit.isBeingReviewed = false
    commit.isReviewed = true
    commit.reviewerEmail = byEmail

  this.markAsNew = (commit, byEmail) ->
    $http.post("/commits/#{commit.id}/unreviewed", email: byEmail).
      error(ErrorReporter.reportServerError)

    commit.isBeingReviewed = false
    commit.isReviewed = false
    commit.isNew = true
    commit.reviewerEmail = null

  this
