class Commit < ActiveRecord::Base
  serialize :payload, Hash

  scope :newest_first, -> { order("id DESC") }

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
