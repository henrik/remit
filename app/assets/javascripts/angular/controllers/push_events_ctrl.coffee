app.controller "PushEventsCtrl", ($scope, $window, Pusher, CommitStats, CurrentUser) ->

  # We must receive pushes even before you visit (=load) one of the subview
  # controllers (e.g. CommitsCtrl), so it can't be handled there.

  subscribe = (event, cb) ->
    Pusher.subscribe "the_channel", event, cb


  subscribe "commits_updated", (data) ->
    $scope.commits = limitRecords data.commits.concat($scope.commits)

  subscribe "comment_updated", (data) ->
    $scope.comments = limitRecords [ data.comment ].concat($scope.comments)

  subscribe "commit_being_reviewed", (data) ->
    updateCommitFrom(data)

  subscribe "commit_reviewed", (data) ->
    updateCommitFrom(data)

  subscribe "commit_unreviewed", (data) ->
    updateCommitFrom(data)

  subscribe "comment_resolved", (data) ->
    updateCommentFrom(data)

  subscribe "comment_unresolved", (data) ->
    updateCommentFrom(data)

  subscribe "app_deployed", (data) ->
    deployedVersion = data.version
    ourVersion = Remit.version
    if ourVersion != deployedVersion
      $window.location.reload()

  # Update commit stats.
  # We watch explicitly so we don't have to recalculate on every single digest.
  # If this ever gets noticeably slow, we could optimize further by debouncing name setting.
  updateCommitStats = -> $scope.stats = CommitStats.stats($scope.commits, CurrentUser.name)
  $scope.$watch "commits", updateCommitStats, true
  $scope.$watch "settings.name", updateCommitStats


  limitRecords = (list) ->
    list.slice(0, $scope.maxRecords)

  updateCommitFrom = (data) ->
    # Ignore updates triggered by the current user to avoid state flickering.
    # Se comment in Commits service.
    userEmail = CurrentUser.email
    updateEmail = data.email
    updateWasTriggeredByTheCurrentUser = updateEmail and userEmail and updateEmail is userEmail
    return if updateWasTriggeredByTheCurrentUser

    for commit in $scope.commits
      if commit.id == data.commit.id
        commit[key] = value for key, value of data.commit
        break

  updateCommentFrom = (data) ->
    for comment in $scope.comments
      if comment.id == data.comment.id
        comment[key] = value for key, value of data.comment
        break
