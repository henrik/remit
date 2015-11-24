# NOTE: Cached data is used for display, so serialization changes will require
#       a migration to apply to all records. E.g: Comment.find_each(&:save)
class CommentSerializer < ApplicationSerializer
  attributes :id,
    :github_id,
    :author_name,
    :author_email,
    :url,
    :body,
    :commit,
    :commit_sha,
    :timestamp,
    :resolver_email,
    :is_new, :is_resolved,
    :thread_identifier

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

  def resolver_email
    comment.resolved_by_author.try(:email)
  end

  def is_new
    comment.new?
  end

  def is_resolved
    comment.resolved?
  end

  alias_method :comment, :object
end
