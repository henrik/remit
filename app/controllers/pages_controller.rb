class PagesController < UsersBaseController
  # The number of records to show (on load and after updates), for speed.
  # Gets slower with more records.
  MAX_RECORDS = 300

  def index
    render locals: {
      max_records: MAX_RECORDS,
      comments: Comment.newest_first.includes_for_listing.limit(MAX_RECORDS).pluck(:cached_data),
      commits: Commit.for_index.pluck(:cached_data),
    }
  end
end
