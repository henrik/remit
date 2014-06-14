class Commit < ActiveRecord::Base
  serialize :payload, Hash

  scope :newest_first, -> { order("id DESC") }

  def self.create_or_update_from_payload(payload, parent_payload)
    payload = payload.deep_symbolize_keys
    parent_payload = parent_payload.deep_symbolize_keys

    payload = payload.merge(
      repository: parent_payload.fetch(:repository),
      pusher: parent_payload.fetch(:pusher),
    )

    commit = Commit.where(sha: payload.fetch(:id)).first_or_initialize
    commit.payload = payload
    commit.save!
    commit
  end

  def as_json(opts = {})
    super(opts.reverse_merge(
      methods: [
        :short_sha,
        :author_name,
        :author_email,
        :summary,
        :url,
        :repository,
      ],
      only: [],
    ))
  end

  def short_sha
    sha.first(10)
  end

  def author_email
    payload.fetch(:author).fetch(:email)
  end

  def author_name
    payload.fetch(:author).fetch(:name)
  end

  def repository
    payload.fetch(:repository).fetch(:name)
  end

  def summary
    payload.fetch(:message).lines.first.first(50)
  end

  def url
    payload.fetch(:url)
  end
end
