#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/controllers/push_events_ctrl

describe "PushEventsCtrl", ->
  Pusher = { subscribe: jasmine.createSpy("subscribe") }

  beforeEach ->
    provide "Pusher", Pusher

  scope = null
  PushEventsCtrl = null
  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    PushEventsCtrl = $controller("PushEventsCtrl", $scope: scope)

  it "subscribes to several Pusher events", ->
    for event in [ "commits_updated", "comment_updated", "commit_being_reviewed", "commit_reviewed", "commit_unreviewed", "app_deployed" ]
      expect(Pusher.subscribe).toHaveBeenCalledWith("the_channel", event, jasmine.any(Function))
