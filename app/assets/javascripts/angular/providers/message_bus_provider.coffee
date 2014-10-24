app.provider "MessageBus", ->
  init = ->
    MessageBus.maxPollInterval = 400  # ms
    MessageBus.start()

  $get: ->
    init()
    window.MessageBus
