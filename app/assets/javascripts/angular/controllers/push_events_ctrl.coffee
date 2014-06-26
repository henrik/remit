app.controller "PushEventsCtrl", ($scope, $window, Pusher, CommitStats) ->

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

  subscribe "app_deployed", (data) ->
    deployedVersion = data.version
    ourVersion = $scope.appVersion
    if ourVersion != deployedVersion
      $window.location.reload()

  # Only run this calculation once for every update of this
  # collection (including property changes within).
  $scope.$watch "commits", ->
    $scope.stats = CommitStats.stats($scope.commits, $scope.settings.name)
  , true


  limitRecords = (list) ->
    list.slice(0, $scope.maxRecords)

  updateCommitFrom = (data) ->
    # Ignore updates triggered by the current user to avoid state flickering.
    # Se comment in Commits service.
    userEmail = $scope.settings.email
    updateEmail = data.email
    updateWasTriggeredByTheCurrentUser = updateEmail and userEmail and updateEmail is userEmail
    return if updateWasTriggeredByTheCurrentUser

    for commit in $scope.commits
      if commit.id == data.commit.id
        commit[key] = value for key, value of data.commit
        break
