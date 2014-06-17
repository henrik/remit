#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/services/fluid_app

describe "Service: FluidApp.running", ->
  it "is true if the location query string contains app=something", ->
    stubQueryParameter "app", "1"

    inject (FluidApp) ->
      expect(FluidApp.running).toBeTruthy()

  it "is false if the location query string does not contain an app value", ->
    stubQueryParameter "app", ""

    inject (FluidApp) ->
      expect(FluidApp.running).toBeFalsy()


  stubQueryParameter = (key, value) ->
    qs = {}
    qs[key] = value
    provide "$location", { search: -> qs }
