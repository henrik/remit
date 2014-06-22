class CommentSerializer < ActiveModel::Serializer
  self.root = false

  attributes :github_id,
    :body,
    :author_name,
    :author_email,
    :url,
    :commit_sha,
    :commit,
    :timestamp

  private

  def author_name
    comment.author.name_or_username
  end

  # May be nil; we don't get a lot of data with comments.
  def author_email
    comment.author.email
  end

  def commit
    comment.commit.try(:as_json)
  end

  alias_method :comment, :object
end
