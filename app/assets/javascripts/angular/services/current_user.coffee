app.service "CurrentUser", (Settings) ->

  @setUp = =>
    @email = Settings.data.email

  @setUp()

  Settings.watch(this.setUp)

  this
