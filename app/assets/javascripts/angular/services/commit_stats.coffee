app.service "CommitStats", () ->
  this.stats = (commits, yourName) ->
    out =
      allUnreviewed: 0
      youCanReview: 0

    for commit in commits
      byYou = yourName and commit.author_name.indexOf(yourName) != -1

      if !commit.reviewed
        out.allUnreviewed   += 1
        out.youCanReview += 1 unless byYou

    out.yourUnreviewed = out.allUnreviewed - out.youCanReview

    out
  this
