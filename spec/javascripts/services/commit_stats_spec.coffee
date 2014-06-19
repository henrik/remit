#= require helpers/spec_helper
#= require angular/services/commit_stats

describe "Service: CommitStats.stats()", ->
  it "counts reviewed commits", ->
    inject (CommitStats) ->
      commits = [
        { reviewed: false },
        { reviewed: true },
        { reviewed: false },
      ]
      stats = CommitStats.stats(commits)
      expect(stats.allUnreviewed).toEqual(2)

  it "counts commits you can review", ->
    inject (CommitStats) ->
      commits = [
        { reviewed: false, author_name: "The Ada L" },
        { reviewed: false, author_name: "Charles Baby" },
        { reviewed: false, author_name: "Ada & Charles" },
      ]
      stats = CommitStats.stats(commits, "Ada")
      expect(stats.youCanReview).toEqual(1)

  it "counts your commits", ->
    inject (CommitStats) ->
      commits = [
        { reviewed: false, author_name: "The Ada L" },
        { reviewed: false, author_name: "Charles Baby" },
        { reviewed: false, author_name: "Ada & Charles" },
      ]
      stats = CommitStats.stats(commits, "Ada")
      expect(stats.yourUnreviewed).toEqual(2)
