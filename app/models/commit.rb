class Commit < ActiveRecord::Base
  serialize :payload, Hash
end
