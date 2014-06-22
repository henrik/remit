class CommitSerializer < ApplicationSerializer
  attributes :id,
    :author_name,
    :author_email,
    :summary,
    :url,
    :repository,
    :timestamp,
    :received_timestamp,
    :is_reviewed,
    :reviewer_email

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

  def is_reviewed
    commit.reviewed?
  end

  alias_method :commit, :object
end
