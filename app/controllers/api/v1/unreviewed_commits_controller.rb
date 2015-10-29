class Api::V1::UnreviewedCommitsController < UsersBaseController
  def index
    commits = Commit.for_index.unreviewed

    # Commits are not guaranteed to be ordered by timestamp, so we do this.
    oldest_timestamp = commits.map(&:timestamp).min_by { |ts| Time.parse(ts) }

    render json: {
      count: commits.count,
      oldest_timestamp: oldest_timestamp,
    }
  end
end
