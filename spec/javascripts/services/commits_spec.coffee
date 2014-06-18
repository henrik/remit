#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/services/commits

describe "Service: Commits.markAsReviewed", ->
  it "optimistically marks the model as reviewed", ->
    inject (Commits) ->
      commit = {}
      Commits.markAsReviewed(commit, "charles@babbage.com")
      expect(commit.reviewed).toBeTruthy()
      expect(commit.reviewer_email).toEqual("charles@babbage.com")

  it "tells the server it was reviewed and returns a promise", ->
    inject (Commits, $httpBackend) ->
      $httpBackend.expect("POST",
        "/commits/123/reviewed",
        email: "charles@babbage.com"
      ).respond()

      commit = { id: 123 }
      rval = Commits.markAsReviewed(commit, "charles@babbage.com")
      expect(typeof(rval.success)).toEqual("function")

      $httpBackend.flush()

describe "Service: Commits.markAsNew", ->
  it "optimistically marks the model as not reviewed", ->
    inject (Commits) ->
      commit = { reviewed: true, reviewer_email: "charles@babbage.com" }
      Commits.markAsNew(commit)
      expect(commit.reviewed).toBeFalsy()
      expect(commit.reviewer_email).toBeNull()

  it "tells the server it was unreviewed", ->
    inject (Commits, $httpBackend) ->
      $httpBackend.expect("DELETE", "/commits/123/unreviewed").respond()

      commit = { id: 123 }
      rval = Commits.markAsNew(commit)
      expect(typeof(rval.success)).toEqual("function")

      $httpBackend.flush()
