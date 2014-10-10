app.provider "MessageBus", ->
  messageBusInit = ->
    MessageBus.enableLongPolling = false
    MessageBus.maxPollInterval = 400
    MessageBus.start()

  $get: ->
    messageBusInit()
    window.MessageBus
