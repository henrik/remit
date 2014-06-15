window.app = angular.module("Remit",
  [ "ngRoute", "ngAnimate", "doowb.angular-pusher", "ui.gravatar", "emoji" ])

app.config (PusherServiceProvider) ->
  # Configure for pusher-fake in tests.
  if window.pusherOptions
    opts = pusherOptions
  else
    opts = {}

  # Uncomment for debug.
  # opts.log = (m) -> window.console.log(m)

  PusherServiceProvider
    .setToken(window.pusherKey)
    .setOptions(opts)

angular.module("ui.gravatar").config (gravatarServiceProvider) ->
    gravatarServiceProvider.secure = true  # https
    gravatarServiceProvider.defaults =
      size: 40

app.run ($rootScope, $location, Pusher) ->
  $rootScope.navClass = (path) ->
    "current" if $location.path() == path

  # We must receive pushes even before the respective controllers have loaded.

  Pusher.subscribe "the_channel", "commits_updated", (data) ->
    console.log "got commits", data.commits

    # concat didn't trigger an update for some reason
    for commit in data.commits.reverse()
      $rootScope.commits.unshift(commit)

  Pusher.subscribe "the_channel", "comment_updated", (data) ->
    console.log "got comment", data.comment
    $rootScope.comments.unshift(data.comment)
