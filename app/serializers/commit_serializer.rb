# NOTE: Cached data is used for display, so serialization changes will require
#       a migration to apply to all records. E.g: Commit.find_each(&:save)
class CommitSerializer < ApplicationSerializer
  attributes :id,
    :author_name,
    :author_email,
    :summary,
    :url,
    :repository,
    :timestamp,
    :received_timestamp,
    :is_new, :is_being_reviewed, :is_reviewed,
    :pending_reviewer_email, :reviewer_email

  private

  def author_name
    commit.author.name
  end

  def author_email
    commit.author.email
  end

  def received_timestamp
    commit.created_at.iso8601
  end

  def reviewer_email
    commit.reviewed_by_author.try(:email)
  end

  def pending_reviewer_email
    commit.review_started_by_author.try(:email)
  end

  def is_new
    commit.new?
  end

  def is_being_reviewed
    commit.being_reviewed?
  end

  def is_reviewed
    commit.reviewed?
  end

  alias_method :commit, :object
end
