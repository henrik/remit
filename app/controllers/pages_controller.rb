class PagesController < UsersBaseController
  # The number of records to show (on load and after updates), for speed.
  # Gets slower with more records.
  MAX_RECORDS = ENV["MAX_RECORDS_TO_SHOW"] ? ENV["MAX_RECORDS_TO_SHOW"].to_i : 300

  def index
    render locals: {
      max_records: MAX_RECORDS,
      comments: Comment.newest_first.includes_for_listing.first(MAX_RECORDS),
      commits: Commit.for_index,
    }
  end
end
