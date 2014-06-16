#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/services/fluid_app

describe "Service: FluidApp.running", ->
  beforeEach module "Remit"

  it "is true if the location query string contains ?app=something", ->
    stubQueryString @, "?app=1"

    inject (FluidApp) ->
      expect(FluidApp.running).toBeTruthy()

  it "is true if the location query string contains &app=something", ->
    stubQueryString @, "?foo=bar&app=1"

    inject (FluidApp) ->
      expect(FluidApp.running).toBeTruthy()

  it "is false if the location query string does not contain an app value", ->
    stubQueryString @, "?app="

    inject (FluidApp) ->
      expect(FluidApp.running).toBeFalsy()


stubQueryString = (context, value) ->
  provide context, "$window", { location: { search: value } }

provide = (context, name, value) ->
  angular.mock.module.call context, ($provide) ->
    $provide.value name, value
    null
