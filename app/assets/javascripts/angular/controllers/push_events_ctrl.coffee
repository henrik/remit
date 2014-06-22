app.controller "PushEventsCtrl", ($scope, $window, Pusher) ->

  # We must receive pushes even before you visit (=load) one of the subview
  # controllers (e.g. CommitsCtrl), so it can't be handled there.

  subscribe = (event, cb) ->
    Pusher.subscribe "the_channel", event, cb


  subscribe "commits_updated", (data) ->
    $scope.commits = limitRecords data.commits.concat($scope.commits)

  subscribe "comment_updated", (data) ->
    $scope.comments = limitRecords [ data.comment ].concat($scope.comments)

  subscribe "commit_reviewed", (data) ->
    updateCommitFrom(data)

  subscribe "commit_unreviewed", (data) ->
    updateCommitFrom(data)

  subscribe "app_deployed", (data) ->
    deployedVersion = data.version
    ourVersion = $scope.appVersion
    if ourVersion != deployedVersion
      $window.location.reload()


  limitRecords = (list) ->
    list.slice(0, $scope.maxRecords)

  updateCommitFrom = (data) ->
    for commit in $scope.commits
      if commit.id == data.id
        commit[key] = value for key, value of data
        break
