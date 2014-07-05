app.service "Comments", ($http, ErrorReporter) ->

  this.yourLastClicked = null

  this.markAsResolved = (comment, byEmail) ->
    post("/comments/#{comment.id}/resolved", email: byEmail)

    comment.isNew = false
    comment.isResolved = true
    comment.resolverEmail = byEmail

  this.markAsNew = (comment, byEmail) ->
    post("/comments/#{comment.id}/unresolved", email: byEmail)

    comment.isResolved = false
    comment.isNew = true
    comment.resolverEmail = null

  post = (args...) ->
    $http.post(args...).
      error(ErrorReporter.reportServerError)

  this
