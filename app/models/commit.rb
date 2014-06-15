class Commit < ActiveRecord::Base
  serialize :payload, Hash

  scope :newest_first, -> { order("id DESC") }

  def self.create_or_update_from_payload(payload, parent_payload)
    payload = payload.deep_symbolize_keys
    parent_payload = parent_payload.deep_symbolize_keys

    payload = payload.merge(
      ref: parent_payload.fetch(:ref),
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
        :id,
        :short_sha,
        :author_name,
        :author_email,
        :summary,
        :url,
        :repository,
        :branch,
        :reviewed,
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

  def branch
    payload.fetch(:ref).split("/").last
  end

  def summary
    payload.fetch(:message).lines.first.first(50)
  end

  def url
    payload.fetch(:url)
  end

  def reviewed?
    reviewed_at?
  end

  # Named without questionmark for as_json.
  # FIXME: Generate JSON in a better way.
  alias_method :reviewed, :reviewed?

  def mark_as_reviewed
    update_attribute(:reviewed_at, Time.now)
  end

  def mark_as_unreviewed
    update_attribute(:reviewed_at, nil)
  end
end
