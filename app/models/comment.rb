class Comment < ActiveRecord::Base
  serialize :payload, Hash
end
