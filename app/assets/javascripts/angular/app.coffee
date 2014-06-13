window.app = angular.module("Remit",
  [ "ngRoute", "doowb.angular-pusher", "ui.gravatar", "emoji" ])

app.config (PusherServiceProvider) ->
  PusherServiceProvider
    .setToken(pusherKey)
    .setOptions({
      #log: (m) -> window.console.log(m)
    })

angular.module("ui.gravatar").config (gravatarServiceProvider) ->
    gravatarServiceProvider.secure = true  # https
    gravatarServiceProvider.defaults =
      size: 40

app.run ($rootScope, $location, Pusher) ->
  $rootScope.navClass = (path) ->
    "current" if $location.path() == path

  # We must receive pushes even before the respective controllers have loaded.

  Pusher.subscribe "the_channel", "commits_updated", (data) ->
    console.log "got commits", JSON.parse(data.commits)

    # unshift would be ineffective; we push and sort with a filter
    # http://stackoverflow.com/a/16874794/6962
    # concat didn't trigger an update for some reason
    for commit in JSON.parse(data.commits)
      $rootScope.commits.push(commit)

  Pusher.subscribe "the_channel", "comment_updated", (data) ->
    console.log "got comment", JSON.parse(data.comment)
    # unshift would be ineffective; we push and sort with a filter
    # http://stackoverflow.com/a/16874794/6962
    $rootScope.comments.push(JSON.parse(data.comment))
