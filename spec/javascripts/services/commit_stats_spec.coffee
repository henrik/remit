#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/services/commit_stats

describe "Service: CommitStats.stats()", ->
  CommitStats = null
  beforeEach inject (_CommitStats_) ->
    CommitStats = _CommitStats_

  it "counts unreviewed commits", ->
    commits = [
      { reviewed: false },
      { reviewed: true },
      { reviewed: false },
    ]
    stats = CommitStats.stats(commits)
    expect(stats.allUnreviewed).toEqual(2)

  it "counts commits you can review", ->
    commits = [
      { reviewed: false, authorName: "The Ada L" },
      { reviewed: false, authorName: "Charles Baby" },
      { reviewed: false, authorName: "Ada & Charles" },
    ]
    stats = CommitStats.stats(commits, "Ada")
    expect(stats.youCanReview).toEqual(1)

  it "counts unreviewed commits by you", ->
    commits = [
      { reviewed: false, authorName: "The Ada L" },
      { reviewed: false, authorName: "Charles Baby" },
      { reviewed: false, authorName: "Ada & Charles" },
    ]
    stats = CommitStats.stats(commits, "Ada")
    expect(stats.yourUnreviewed).toEqual(2)
