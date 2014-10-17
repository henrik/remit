app.provider "MessageBus", ->
  init = ->
    # We couldn't get it to work with long polling.
    # TODO: We can probably fix it by using Unicorn's after_fork.
    MessageBus.enableLongPolling = false

    MessageBus.maxPollInterval = 400  # ms
    MessageBus.start()

  $get: ->
    init()
    window.MessageBus
