app.controller "PushEventsCtrl", ($scope, Pusher) ->

  # We must receive pushes even before you visit (=load) one of the subview
  # controllers (e.g. CommitsCtrl), so it can't be handled there.

  subscribe = (event, cb) ->
    Pusher.subscribe "the_channel", event, cb

  limitRecords = (list) ->
    list.slice(0, $scope.maxRecords)

  subscribe "commits_updated", (data) ->
    $scope.commits = limitRecords data.commits.concat($scope.commits)

  subscribe "comment_updated", (data) ->
    $scope.comments = limitRecords [ data.comment ].concat($scope.comments)

  subscribe "commit_reviewed", (data) ->
    for commit in $scope.commits
      if commit.id == data.id
        commit.reviewed = true
        commit.reviewer_email = data.reviewer_email
        return  # Break the loop

  subscribe "commit_unreviewed", (data) ->
    for commit in $scope.commits
      if commit.id == data.id
        commit.reviewed = false
        commit.reviewer_email = null
        return  # Break the loop
