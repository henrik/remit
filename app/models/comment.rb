class Comment < ActiveRecord::Base
  serialize :payload, Hash

  scope :newest_first, -> { order("id DESC") }

  def as_json(opts = {})
    super(opts.reverse_merge(
      except: [ :payload ],
    ))
  end
end
