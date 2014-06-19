class Comment < ActiveRecord::Base
  serialize :payload, Hash

  belongs_to :author
  belongs_to :commit,
    foreign_key: :commit_sha,
    primary_key: :sha

  scope :newest_first, -> { order("id DESC") }
  scope :includes_for_listing, -> { includes({ :commit => :author }, :author) }

  def self.create_or_update_from_payload(payload)
    payload = payload.deep_symbolize_keys

    # This is the only attribute we get.
    author_username = payload.fetch(:user).fetch(:login)
    author = Author.create_or_update_from_payload(username: author_username)

    comment = Comment.where(github_id: payload[:id]).first_or_initialize
    comment.commit_sha = payload[:commit_id]
    comment.payload = payload
    comment.author = author
    comment.save!

    comment
  end

  def as_json(opts = {})
    super(opts.reverse_merge(
      methods: [
        :github_id,
        :body,
        :author_name,
        :url,
        :commit_author_name,
        :commit_sha,
        # TODO: generate JSON differently so we can call this "commit"
        :commit_data,
        :author_email,
        :timestamp,
      ],
      only: [],
    ))
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

  def author_name
    author.name_or_username
  end

  def commit_data
    commit && commit.as_json
  end

  # May be nil.
  def author_email
    author.email
  end
end
