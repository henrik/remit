#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/services/current_user

describe "Service: CurrentUser", ->
  CurrentUser = null
  beforeEach inject (_CurrentUser_) ->
    CurrentUser = _CurrentUser_

  describe ".isAuthorOf", ->
    it "is true if the authorName matches by substring", ->
      CurrentUser.name = "Baz"
      expect(CurrentUser.isAuthorOf(authorName: "Foo, Bar and Baz")).toBeTruthy()

    it "is false if the authorName does not match by substring", ->
      CurrentUser.name = "Banana"
      expect(CurrentUser.isAuthorOf(authorName: "Foo, Bar and Baz")).toBeFalsy()

    it "is false if there's no CurrentUser name", ->
      CurrentUser.name = null
      expect(CurrentUser.isAuthorOf(authorName: "Foo, Bar and Baz")).toBeFalsy()
