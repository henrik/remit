# We use cookies rather than localStorage because Fluid.app doesn't
# seem to preserve localStorage in "Browsa panes".
#
# Cookie lib: https://github.com/ivpusic/angular-cookie

app.service "Settings", (ipCookie) ->
  @key = "settings"
  @data = {}

  @load = ->
    @data = ipCookie(@key) || {}

  @save = ->
    ipCookie("settings", @data, expires: 999999)  # This number of days.

  @reset = ->
    ipCookie.remove(@key)

  this
