app.service "CurrentUser", (Settings) ->

  @setUp = =>
    @email = Settings.data.email
    @name = Settings.data.name

  @isAuthorOf = (thing) ->
    @name and thing.authorName.indexOf(@name) != -1

  @setUp()

  Settings.watch(this.setUp)

  this
