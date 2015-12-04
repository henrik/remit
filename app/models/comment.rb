class Comment < ActiveRecord::Base
  serialize :payload, Hash

  belongs_to :author
  belongs_to :resolved_by_author, class_name: Author

  belongs_to :commit,
    foreign_key: :commit_sha,
    primary_key: :sha

  scope :newest_first, -> { order("id DESC") }
  scope :includes_for_listing, -> { includes({ :commit => :author }, :author) }

  def self.create_or_update_from_payload(payload)
    CreateOrUpdateFromPayload.call(payload)
  end

  def as_json(_opts = {})
    CommentSerializer.new(self).as_json
  end

  def body
    payload[:body]
  end

  def url
    payload[:html_url]
  end

  def timestamp
    payload[:created_at]
  end

  def thread_identifier
    [ payload[:commit_id], payload[:position], payload[:line] ].join(":")
  end

  def new?
    not resolved?
  end

  def resolved?
    resolved_at?
  end

  def mark_as_resolved_by(email)
    update_attributes!(
      resolved_at: Time.now,
      resolved_by_author: find_author_for_email(email),
    )
  end

  def mark_as_unresolved
    update_attributes!(
      resolved_at: nil,
      resolved_by_author: nil,
    )
  end

  private

  def find_author_for_email(email)
    email.presence && Author.create_or_update_from_payload(email: email)
  end
end
