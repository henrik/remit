class PagesController < UserFacingController
  # The number of records to show (on load and after updates), for speed.
  # Gets slower with more records.
  MAX_RECORDS = 200

  def index
    render locals: {
      max_records: MAX_RECORDS,
      comments: Comment.newest_first.includes_for_listing.first(MAX_RECORDS),
      commits: Commit.newest_first.includes_for_listing.first(MAX_RECORDS),
    }
  end
end
