class CommentSerializer < ApplicationSerializer
  attributes :github_id,
    :author_name,
    :author_email,
    :url,
    :body,
    :commit,
    :commit_sha,
    :timestamp

  private

  def author_name
    comment.author.name_or_username
  end

  # May be nil; we don't get a lot of data with comments.
  def author_email
    comment.author.email
  end

  # May or may not have an associated commit.
  def commit
    comment.commit.try(:as_json)
  end

  alias_method :comment, :object
end
