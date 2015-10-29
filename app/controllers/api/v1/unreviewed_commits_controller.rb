class Api::V1::UnreviewedCommitsController < UsersBaseController
  def index
    commits = Commit.for_index.unreviewed

    # Commits are not guaranteed to be ordered by timestamp, so we do this.
    oldest_time = commits.map { |c| Time.parse(c.timestamp) }.min

    oldest_timestamp = oldest_time && oldest_time.iso8601
    oldest_age = oldest_time && (Time.now - oldest_time).to_i

    render json: {
      count: commits.count,
      oldest_timestamp: oldest_timestamp,
      oldest_age_in_seconds: oldest_age,
    }
  end
end
