#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/services/commit_stats

describe "Service: CommitStats.stats()", ->
  CommitStats = null
  beforeEach inject (_CommitStats_) ->
    CommitStats = _CommitStats_

  it "counts unreviewed commits", ->
    commits = [
      { isReviewed: false },
      { isReviewed: true },
      { isReviewed: false },
    ]
    stats = CommitStats.stats(commits)
    expect(stats.allUnreviewed).toEqual(2)

  it "counts commits you can review", ->
    commits = [
      { isReviewed: false, authorName: "The Ada L" },
      { isReviewed: false, authorName: "Charles Baby" },
      { isReviewed: false, authorName: "Ada & Charles" },
    ]
    stats = CommitStats.stats(commits, "Ada")
    expect(stats.youCanReview).toEqual(1)

  it "counts unreviewed commits by you", ->
    commits = [
      { isReviewed: false, authorName: "The Ada L" },
      { isReviewed: false, authorName: "Charles Baby" },
      { isReviewed: false, authorName: "Ada & Charles" },
    ]
    stats = CommitStats.stats(commits, "Ada")
    expect(stats.yourUnreviewed).toEqual(2)

  it "determines the oldest commit you can review", ->
    commits = [
      { id: 44, isReviewed: false, authorName: "Ada" },
      { id: 33, isReviewed: false, authorName: "Ada" },
      { id: 22, isReviewed: false, authorName: "Charles" },
      { id: 11, isReviewed: true,  authorName: "Ada" },
    ]
    stats = CommitStats.stats(commits, "Charles")
    expect(stats.oldestCommitYouCanReview.id).toEqual(33)
