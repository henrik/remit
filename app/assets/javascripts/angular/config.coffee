app.config (PusherServiceProvider) ->
  # Configure for pusher-fake in tests.
  opts = window.pusherOptions || {}

  # Uncomment for debug.
  # opts.log = (m) -> window.console.log(m)

  PusherServiceProvider
    .setToken(window.pusherKey)
    .setOptions(opts)

angular.module("ui.gravatar").config (gravatarServiceProvider) ->
    gravatarServiceProvider.secure = true  # https
    gravatarServiceProvider.defaults =
      size: 40
      default: "mm"  # "Mystery man" silhouette placeholder.
