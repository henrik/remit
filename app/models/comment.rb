class Comment < ActiveRecord::Base
  serialize :payload, Hash

  belongs_to :commit,
    foreign_key: :commit_sha,
    primary_key: :sha

  scope :newest_first, -> { order("id DESC") }

  def self.create_or_update_from_payload(payload)
    payload = payload.deep_symbolize_keys
    comment = Comment.where(github_id: payload[:id]).first_or_initialize
    comment.commit_sha = payload[:commit_id]
    comment.payload = payload
    comment.save!
    comment
  end

  def as_json(opts = {})
    super(opts.reverse_merge(
      methods: [ :body, :sender_name, :url ],
      only: [],
    ))
  end

  def body
    payload[:body]
  end

  def url
    payload[:html_url]
  end

  def sender_name
    # The payload sadly doesn't include a full name.
    # The commit payloads do, so maybe we could map via that?
    payload[:user][:login]
  end
end
