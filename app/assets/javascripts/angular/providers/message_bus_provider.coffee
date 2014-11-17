app.provider "MessageBus", ->
  init = ->
    MessageBus.callbackInterval = 500  # ms
    MessageBus.start()

  $get: ->
    init()
    window.MessageBus
