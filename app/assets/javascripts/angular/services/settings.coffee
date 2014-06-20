# We use cookies rather than localStorage because Fluid.app doesn't
# seem to preserve localStorage in "Browsa panes".
#
# Cookie lib: https://github.com/ivpusic/angular-cookie

app.service "Settings", (ipCookie) ->
  @key = "settings"
  @data = {}

  @load = (defaultData) ->
    @data = ipCookie(@key) || {}
    for key, value of defaultData
      @data[key] = value unless (key of @data)
    @data

  @save = ->
    ipCookie("settings", @data, expires: 999999)  # This number of days.

  @reset = ->
    ipCookie.remove(@key)

  this
