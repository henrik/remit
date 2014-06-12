class Comment < ActiveRecord::Base
  serialize :payload, Hash

  scope :newest_first, -> { order("id DESC") }

  def to_json
    super(
      except: [ :payload ],
    )
  end
end
