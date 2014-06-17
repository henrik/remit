window.app = angular.module "Remit",
  [
    "ngRoute", "ngAnimate",
    "doowb.angular-pusher", "ui.gravatar", "LocalStorageModule",
  ]

app.run ($rootScope, $location, localStorageService, Pusher) ->

  $rootScope.settings =
    email: localStorageService.get("email")
    name: localStorageService.get("name")

  $rootScope.navClass = (path) ->
    "current" if $location.path() == path

  # Why is this not in the respective controllers?
  # Because we must receive pushes even before you visit (=load) them.

  subscribe = (event, cb) ->
    Pusher.subscribe "the_channel", event, cb

  subscribe "commits_updated", (data) ->
    $rootScope.commits = data.commits.
      concat($rootScope.commits).
      slice(0, $rootScope.maxRecords)  # Stay within the maxRecords limit.

  subscribe "comment_updated", (data) ->
    $rootScope.comments = [ data.comment ].
      concat($rootScope.comments).
      slice(0, $rootScope.maxRecords)  # Stay within the maxRecords limit.

  subscribe "commit_reviewed", (data) ->
    for commit in $rootScope.commits
      if commit.id == data.id
        commit.reviewed = true
        return  # Break the loop

  subscribe "commit_unreviewed", (data) ->
    for commit in $rootScope.commits
      if commit.id == data.id
        commit.reviewed = false
        return  # Break the loop
