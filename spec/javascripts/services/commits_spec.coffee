#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/services/commits

describe "Service: Commits", ->
  beforeEach provide "ErrorReporter", {}

  describe ".startReview", ->
    it "optimistically marks the model as being in review", ->
      inject (Commits) ->
        commit = { isNew: true }
        Commits.startReview(commit, "charles@babbage.com")
        expect(commit.isNew).toBeFalsy()
        expect(commit.isBeingReviewed).toBeTruthy()
        expect(commit.pendingReviewerEmail).toEqual("charles@babbage.com")

    it "tells the server it was reviewed", ->
      inject (Commits, $httpBackend) ->
        $httpBackend.expect("POST",
          "/commits/123/started_review",
          email: "charles@babbage.com"
        ).respond()

        commit = { id: 123 }
        Commits.startReview(commit, "charles@babbage.com")

        $httpBackend.flush()

  describe ".markAsReviewed", ->
    it "optimistically marks the model as reviewed", ->
      inject (Commits) ->
        commit = { isBeingReviewed: true }
        Commits.markAsReviewed(commit, "charles@babbage.com")
        expect(commit.isBeingReviewed).toBeFalsy()
        expect(commit.isReviewed).toBeTruthy()
        expect(commit.reviewerEmail).toEqual("charles@babbage.com")

    it "tells the server it was reviewed", ->
      inject (Commits, $httpBackend) ->
        $httpBackend.expect("POST",
          "/commits/123/reviewed",
          email: "charles@babbage.com"
        ).respond()

        commit = { id: 123 }
        Commits.markAsReviewed(commit, "charles@babbage.com")

        $httpBackend.flush()

  describe ".markAsNew", ->
    it "optimistically marks the model as not reviewed or in review", ->
      inject (Commits) ->
        commit = { isBeingReviewed: true, isReviewed: true, reviewerEmail: "charles@babbage.com" }
        Commits.markAsNew(commit)
        expect(commit.isBeingReviewed).toBeFalsy()
        expect(commit.isReviewed).toBeFalsy()
        expect(commit.isNew).toBeTruthy()
        expect(commit.reviewerEmail).toBeNull()

    it "tells the server it was unreviewed", ->
      inject (Commits, $httpBackend) ->
        $httpBackend.expect("POST",
          "/commits/123/unreviewed",
          email: "charles@babbage.com"
        ).respond()

        commit = { id: 123 }
        Commits.markAsNew(commit, "charles@babbage.com")

        $httpBackend.flush()
