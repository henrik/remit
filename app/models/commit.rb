class Commit < ActiveRecord::Base
  # Some argue 50 chars is a good length for the summary part of a commit message.
  # http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
  MESSAGE_SUMMARY_LENGTH = 50

  serialize :payload, Hash
  serialize :cached_data, Hash

  belongs_to :author
  belongs_to :reviewed_by_author, class: Author
  belongs_to :review_started_by_author, class: Author

  scope :newest_first, -> { order("commits.id DESC") }
  scope :includes_for_listing, -> { includes(:author, :reviewed_by_author) }
  scope :unreviewed, -> { where("commits.reviewed_at IS NULL") }

  scope :for_index, -> {
    newest_first.includes_for_listing.limit(PagesController::MAX_RECORDS)
  }

  after_save -> { update_column(:cached_data, as_json) }

  def self.create_or_update_from_payload(commit_payload, push_payload)
    CreateOrUpdateFromPayload.call(commit_payload, push_payload)
  end

  def as_json(_opts = {})
    CommitSerializer.new(self).as_json
  rescue
    return {} if Rails.env.test? # unrelastic data in tests don't always serialize
    raise
  end

  def repository
    payload.fetch(:repository).fetch(:name)
  end

  def summary
    message.lines.first.first(MESSAGE_SUMMARY_LENGTH)
  end

  def url
    payload.fetch(:url)
  end

  def timestamp
    payload.fetch(:timestamp)
  end

  def new?
    !reviewed? && !being_reviewed?
  end

  def being_reviewed?
    review_started_at? && !reviewed?
  end

  def reviewed?
    reviewed_at?
  end

  def mark_as_being_reviewed_by(email)
    update_attributes!(
      review_started_at: Time.now,
      review_started_by_author: find_author_for_email(email),
      reviewed_at: nil,
      reviewed_by_author: nil,
    )
  end

  def mark_as_reviewed_by(email)
    update_attributes!(
      reviewed_at: Time.now,
      reviewed_by_author: find_author_for_email(email),
    )
  end

  def mark_as_unreviewed
    update_attributes!(
      review_started_at: nil,
      review_started_by_author: nil,
      reviewed_at: nil,
      reviewed_by_author: nil,
    )
  end

  private

  def message
    payload.fetch(:message)
  end

  def find_author_for_email(email)
    email.presence && Author.create_or_update_from_payload(email: email)
  end
end
