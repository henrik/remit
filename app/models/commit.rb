class Commit < ActiveRecord::Base
  serialize :payload, Hash

  scope :newest_first, -> { order("id DESC") }

  def self.create_or_update_from_payload(payload, parent_payload)
    payload = payload.deep_symbolize_keys
    payload = payload.merge(
      repository: parent_payload[:repository],
      pusher: parent_payload[:pusher],
    )

    comment = Commit.where(sha: payload[:id]).first_or_initialize
    comment.payload = payload
    comment.save!
  end

  def short_sha
    sha.first(10)
  end

  def as_json(opts = {})
    super(opts.reverse_merge(
      except: [ :payload ],
      methods: [ :short_sha ],
    ))
  end
end
