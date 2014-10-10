#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/controllers/push_events_ctrl

describe "PushEventsCtrl", ->
  MessageBus = { subscribe: jasmine.createSpy("subscribe") }

  scope = null
  PushEventsCtrl = null
  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    PushEventsCtrl = $controller("PushEventsCtrl", $scope: scope, MessageBus: MessageBus)

  it "subscribes to several MessageBus channels", ->
    for channel in [ "commits_updated", "comment_updated", "commit_being_reviewed", "commit_reviewed", "commit_unreviewed", "comment_resolved", "comment_unresolved", "app_deployed" ]
      expect(MessageBus.subscribe).toHaveBeenCalledWith(channel, jasmine.any(Function))
