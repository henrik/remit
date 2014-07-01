app.service "Comments", ($http) ->
  this.yourLastClicked = null

  this.markAsResolved = (comment, byEmail) ->
    promise = $http.post("/comments/#{comment.id}/resolved", email: byEmail)
    comment.isNew = false
    comment.isResolved = true
    comment.resolverEmail = byEmail
    promise

  this.markAsNew = (comment, byEmail) ->
    promise = $http.post("/comments/#{comment.id}/unresolved", email: byEmail)
    comment.isResolved = false
    comment.isNew = true
    comment.resolverEmail = null
    promise

  this
