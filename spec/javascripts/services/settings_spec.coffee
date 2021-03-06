#= require helpers/spec_helper
#= require angular-cookie
#= require ./settings_fake_app
#= require angular/services/settings

describe "Service: Settings", ->
  Settings = null
  ipCookie = null
  beforeEach inject (_Settings_, _ipCookie_) ->
    Settings = _Settings_
    ipCookie = _ipCookie_

  beforeEach ->
    Settings.reset()

  it "can write and read settings", ->
    # This is the suggested usage pattern.
    myScope = {}
    myScope.settings = Settings.load()

    expect(myScope.settings.name).toBe(undefined)

    myScope.settings.name = "Ada"
    Settings.save()

    myScope.settings = Settings.load()
    expect(myScope.settings.name).toEqual("Ada")

  it "accepts defaults", ->
    settings = Settings.load(mydefault: "hello")
    expect(settings.mydefault).toEqual("hello")

    Settings.save()

    settings = Settings.load(mydefault: "something else")
    expect(settings.mydefault).toEqual("hello")

  it "applies defaults if a setting key was previously unknown", ->
    settings = Settings.load()
    expect(settings.mydefault).toBeUndefined()

    Settings.save()

    settings = Settings.load(mydefault: "hello")
    expect(settings.mydefault).toEqual("hello")
