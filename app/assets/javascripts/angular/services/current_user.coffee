app.service "CurrentUser", (Settings) ->

  @setUp = =>
    @email = Settings.data.email
    @name = Settings.data.name

  @setUp()

  Settings.watch(this.setUp)

  this
