class PagesController < UserFacingController
  # The number of records to show (on load and after updates).
  # The reason for a limit is that we expect (but haven't verified) it could get slow.
  MAX_RECORDS = 250

  def index
    render locals: {
      max_records: MAX_RECORDS,
      comments: Comment.newest_first.includes_for_listing.last(MAX_RECORDS),
      commits: Commit.newest_first.includes_for_listing.last(MAX_RECORDS),
    }
  end
end
