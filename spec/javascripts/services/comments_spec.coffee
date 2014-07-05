#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/services/comments

describe "Service: Comments", ->
  beforeEach provide "ErrorReporter", {}

  describe ".markAsResolved", ->
    it "optimistically marks the model as resolved", ->
      inject (Comments) ->
        comment = { isNew: true }
        Comments.markAsResolved(comment, "charles@babbage.com")
        expect(comment.isNew).toBeFalsy()
        expect(comment.isResolved).toBeTruthy()
        expect(comment.resolverEmail).toEqual("charles@babbage.com")

    it "tells the server it was resolved and returns a promise", ->
      inject (Comments, $httpBackend) ->
        $httpBackend.expect("POST",
          "/comments/123/resolved",
          email: "charles@babbage.com"
        ).respond()

        comment = { id: 123 }
        Comments.markAsResolved(comment, "charles@babbage.com")

        $httpBackend.flush()

  describe ".markAsNew", ->
    it "optimistically marks the model as unresolved", ->
      inject (Comments) ->
        comment = { isResolved: true, resolverEmail: "charles@babbage.com" }
        Comments.markAsNew(comment)
        expect(comment.isResolved).toBeFalsy()
        expect(comment.isNew).toBeTruthy()
        expect(comment.resolverEmail).toBeNull()

    it "tells the server it was marked as new", ->
      inject (Comments, $httpBackend) ->
        $httpBackend.expect("POST",
          "/comments/123/unresolved",
          email: "charles@babbage.com"
        ).respond()

        comment = { id: 123 }
        Comments.markAsNew(comment, "charles@babbage.com")

        $httpBackend.flush()
