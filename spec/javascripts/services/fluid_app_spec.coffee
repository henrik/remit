#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/services/fluid_app

describe "Service: FluidApp.running", ->
  it "is true if the user agent contains 'FluidApp'", ->
    stubUserAgent "Bla FluidApp Bla"

    inject (FluidApp) ->
      expect(FluidApp.running).toBeTruthy()

  it "is false if the user agent does not contain 'FluidApp'", ->
    stubUserAgent "Bla Chrome Bla"

    inject (FluidApp) ->
      expect(FluidApp.running).toBeFalsy()


  stubUserAgent = (agent) ->
    provide "$window", { navigator: { userAgent: agent } }
