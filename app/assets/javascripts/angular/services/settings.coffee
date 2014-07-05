# We use cookies rather than localStorage because Fluid.app doesn't
# seem to preserve localStorage in "Browsa panes".
#
# Cookie lib: https://github.com/ivpusic/angular-cookie

app.service "Settings", (ipCookie) ->
  @key = "settings"
  @data = {}
  @watchers = []

  @load = (defaultData) ->
    @data = ipCookie(@key) || {}
    for key, value of defaultData
      @data[key] = value unless (key of @data)
    @_triggerWatchers()
    @data

  @save = ->
    ipCookie("settings", @data, expires: 999999)  # This number of days.
    @_triggerWatchers()

  @watch = (cb) ->
    @watchers.push(cb)

  @_reset = ->
    @data = {}
    ipCookie.remove(@key)

  @_triggerWatchers = ->
    cb(@data) for cb in @watchers

  this
