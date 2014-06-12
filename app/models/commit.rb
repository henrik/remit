class Commit < ActiveRecord::Base
  serialize :payload, Hash

  scope :newest_first, -> { order("id DESC") }
end
