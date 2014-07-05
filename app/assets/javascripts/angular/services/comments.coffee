app.service "Comments", ($http, ErrorReporter) ->

  this.yourLastClicked = null

  this.markAsResolved = (comment, byEmail) ->
    $http.post("/comments/#{comment.id}/resolved", email: byEmail).
      error(ErrorReporter.reportServerError)

    comment.isNew = false
    comment.isResolved = true
    comment.resolverEmail = byEmail

  this.markAsNew = (comment, byEmail) ->
    $http.post("/comments/#{comment.id}/unresolved", email: byEmail).
      error(ErrorReporter.reportServerError)

    comment.isResolved = false
    comment.isNew = true
    comment.resolverEmail = null

  this
