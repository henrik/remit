#= require helpers/spec_helper
#= require angular/services/commit_stats

describe "Service: CommitStats.stats()", ->
  CommitStats = null
  beforeEach inject (_CommitStats_) ->
    CommitStats = _CommitStats_

  it "counts reviewed commits", ->
    commits = [
      { reviewed: false },
      { reviewed: true },
      { reviewed: false },
    ]
    stats = CommitStats.stats(commits)
    expect(stats.allUnreviewed).toEqual(2)

  it "counts commits you can review", ->
    commits = [
      { reviewed: false, author_name: "The Ada L" },
      { reviewed: false, author_name: "Charles Baby" },
      { reviewed: false, author_name: "Ada & Charles" },
    ]
    stats = CommitStats.stats(commits, "Ada")
    expect(stats.youCanReview).toEqual(1)

  it "counts your commits", ->
    commits = [
      { reviewed: false, author_name: "The Ada L" },
      { reviewed: false, author_name: "Charles Baby" },
      { reviewed: false, author_name: "Ada & Charles" },
    ]
    stats = CommitStats.stats(commits, "Ada")
    expect(stats.yourUnreviewed).toEqual(2)
