class Commit < ActiveRecord::Base
  # Some argue 50 chars is a good length for the summary part of a commit message.
  # http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
  MESSAGE_SUMMARY_LENGTH = 50

  serialize :payload, Hash

  belongs_to :author
  belongs_to :reviewed_by_author, class: Author

  scope :newest_first, -> { order("id DESC") }
  scope :includes_for_listing, -> { includes(:author, :reviewed_by_author) }

  def self.create_or_update_from_payload(payload, parent_payload)
    payload = payload.deep_symbolize_keys
    parent_payload = parent_payload.deep_symbolize_keys

    payload = payload.merge(
      repository: parent_payload.fetch(:repository),
    )

    author_payload = payload.fetch(:author)
    author = Author.create_or_update_from_payload(author_payload)

    commit = Commit.where(sha: payload.fetch(:id)).first_or_initialize
    commit.payload = payload
    commit.author = author
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
        :reviewer_email,
      ],
      only: [],
    ))
  end

  def short_sha
    sha.first(10)
  end

  def author_email
    author.email
  end

  def author_name
    author.name
  end

  def repository
    payload.fetch(:repository).fetch(:name)
  end

  def summary
    payload.fetch(:message).lines.first.first(MESSAGE_SUMMARY_LENGTH)
  end

  def url
    payload.fetch(:url)
  end

  def reviewer_email
    reviewed_by_author_id && reviewed_by_author.email
  end

  def reviewed?
    reviewed_at?
  end

  # Named without questionmark for as_json.
  # FIXME: Generate JSON in a better way.
  alias_method :reviewed, :reviewed?

  def mark_as_reviewed_by(email)
    author = email.presence && Author.create_or_update_from_payload(email: email)

    update_attributes!(
      reviewed_at: Time.now,
      reviewed_by_author: author,
    )
  end

  def mark_as_unreviewed
    update_attributes!(
      reviewed_at: nil,
      reviewed_by_author: nil,
    )
  end
end
