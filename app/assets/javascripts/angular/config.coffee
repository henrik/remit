app.config (PusherServiceProvider) ->
  opts = Remit.pusherConfig.options

  # Uncomment for debug.
  # opts.log = (m) -> window.console.log(m)

  PusherServiceProvider
    .setToken(Remit.pusherConfig.key)
    .setOptions(opts)

angular.module("ui.gravatar").config (gravatarServiceProvider) ->
    gravatarServiceProvider.secure = true  # https
    gravatarServiceProvider.defaults =
      size: 40
      # Co-workers thought it would be fun to X-rate their Gravatar…
      # GitHub shows them, so we will too.
      rating: "x"
      default: "mm"  # "Mystery man" silhouette placeholder.
