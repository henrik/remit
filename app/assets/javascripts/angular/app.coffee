window.app = angular.module "Remit",
  [
    "ngRoute", "ngAnimate",
    "doowb.angular-pusher", "ui.gravatar", "LocalStorageModule",
  ]

app.run ($rootScope, $location, Pusher) ->
  $rootScope.navClass = (path) ->
    "current" if $location.path() == path

  # Why is this not in the respective controllers? Because we
  # must receive pushes even before you visit (=load) them.

  subscribe = (event, cb) ->
    Pusher.subscribe "the_channel", event, cb

  subscribe "commits_updated", (data) ->
    # concat didn't trigger an update for some reason
    for commit in data.commits.reverse()
      $rootScope.commits.unshift(commit)

  subscribe "comment_updated", (data) ->
    $rootScope.comments.unshift(data.comment)

  subscribe "commit_reviewed", (data) ->
    for commit in $rootScope.commits
      if commit.id == data.id
        commit.reviewed = true
        return  # Break the loop

  subscribe "commit_unreviewed", (data) ->
    for commit in $rootScope.commits
      if commit.id == data.id
        commit.reviewed = false
        return  # Break the loop
