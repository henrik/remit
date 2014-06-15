#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/directives

describe "fluidAppLink directive", ->
  beforeEach module "Remit"

  $compile = $rootScope = undefined
  FluidApp = undefined

  beforeEach ->
    module ($provide) ->
      $provide.value("FluidApp", {})
      null

    inject (_FluidApp_) ->
      FluidApp = _FluidApp_

    inject (_$compile_, _$rootScope_) ->
      $compile = _$compile_
      $rootScope = _$rootScope_

  compile = (html) ->
    element = $compile(html)($rootScope)
    $rootScope.$digest()
    element

  it "adds no target if FluidApp.running is true", ->
    FluidApp.running = true
    element = compile "<a href='google' fluid-app-link>banan</a>"
    expect(element.attr("target")).toBeUndefined()

  it "adds target=_blank if FluidApp.running is false", ->
    FluidApp.running = false
    element = compile "<a href='google' fluid-app-link>banan</a>"
    expect(element.attr("target")).toBe("_blank")
