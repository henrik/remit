class PagesController < UserFacingController
  # The number of records to show (on load and after updates).
  # The reason for a limit is that we expect (but haven't verified) it could get slow.
  NUMBER_OF_COMMENTS = 250
  NUMBER_OF_COMMITS  = 250

  def index
    render locals: {
      comments: Comment.newest_first.include_commits.last(NUMBER_OF_COMMENTS),
      commits: Commit.newest_first.last(NUMBER_OF_COMMITS),
    }
  end
end
