app.service "CommitStats", () ->
  this.stats = (commits, yourName) ->
    out =
      allUnreviewed: 0
      youCanReview: 0
      oldestTimestampYouCanReview: null
      oldestIdYouCanReview: null

    for commit in commits
      byYou = commit.hasAuthor(yourName)

      if !commit.isReviewed
        out.allUnreviewed += 1
        unless byYou
          out.youCanReview += 1
          out.oldestCommitYouCanReview = commit

    out.yourUnreviewed = out.allUnreviewed - out.youCanReview

    out
  this
