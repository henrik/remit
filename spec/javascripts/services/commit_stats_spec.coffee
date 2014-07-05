#= require helpers/spec_helper
#= require helpers/fake_app
#= require angular/models/commit
#= require angular/services/commit_stats

describe "Service: CommitStats.stats()", ->
  CommitStats = null
  beforeEach inject (_CommitStats_) ->
    CommitStats = _CommitStats_

  it "counts unreviewed commits", ->
    commits = [
      new Commit(isReviewed: false),
      new Commit(isReviewed: true),
      new Commit(isReviewed: false),
    ]
    stats = CommitStats.stats(commits)
    expect(stats.allUnreviewed).toEqual(2)

  it "counts commits you can review", ->
    commits = [
      new Commit(isReviewed: false, authorName: "The Ada L"),
      new Commit(isReviewed: false, authorName: "Charles Baby"),
      new Commit(isReviewed: false, authorName: "Ada & Charles"),
    ]
    stats = CommitStats.stats(commits, "Ada")
    expect(stats.youCanReview).toEqual(1)

  it "counts unreviewed commits by you", ->
    commits = [
      new Commit(isReviewed: false, authorName: "The Ada L"),
      new Commit(isReviewed: false, authorName: "Charles Baby"),
      new Commit(isReviewed: false, authorName: "Ada & Charles"),
    ]
    stats = CommitStats.stats(commits, "Ada")
    expect(stats.yourUnreviewed).toEqual(2)

  it "determines the oldest commit you can review", ->
    commits = [
      new Commit(id: 44, isReviewed: false, authorName: "Ada"),
      new Commit(id: 33, isReviewed: false, authorName: "Ada"),
      new Commit(id: 22, isReviewed: false, authorName: "Charles"),
      new Commit(id: 11, isReviewed: true,  authorName: "Ada"),
    ]
    stats = CommitStats.stats(commits, "Charles")
    expect(stats.oldestCommitYouCanReview.id).toEqual(33)
