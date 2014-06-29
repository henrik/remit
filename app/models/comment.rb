class Comment < ActiveRecord::Base
  serialize :payload, Hash

  belongs_to :author
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
end
