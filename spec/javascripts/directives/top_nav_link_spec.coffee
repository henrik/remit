#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/directives/top_nav_link

describe "Directive: topNavLink", ->

  fakePath = "/fake"

  beforeEach ->
    provide "$location", { path: -> fakePath }

  $compile = $rootScope = $location = undefined
  beforeEach inject (_$compile_, _$rootScope_) ->
    $compile = _$compile_
    $rootScope = _$rootScope_

  it "preserves the outer element", ->
    element = compile "<li foo='bar' top-nav-link='/path'>mytext</li>"

    expect(element[0].tagName).toBe("LI")
    expect(element.attr("foo")).toBe("bar")

  it "adds a link inside the current element", ->
    element = compile "<li top-nav-link='/path'>mytext</li>"

    innerLink = element.find("a")
    expect(innerLink.text()).toEqual("mytext")
    expect(innerLink.attr("href")).toEqual("/path")

  it "keeps a 'current' class as long as the href matches the current location", ->
    fakePath = "/path"
    element = compile "<li top-nav-link='/path'>mytext</li>"

    expect(element.hasClass("current")).toBeTruthy()

    fakePath = "/other-path"
    $rootScope.$digest()
    expect(element.hasClass("current")).toBeFalsy()

    fakePath = "/path"
    $rootScope.$digest()
    expect(element.hasClass("current")).toBeTruthy()


  compile = (html) ->
    element = $compile(html)($rootScope)
    $rootScope.$digest()
    element
