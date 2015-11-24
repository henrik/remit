class AddCachedDataToComments < ActiveRecord::Migration
  def change
    add_column :comments, :cached_data, :text

    Comment.find_each do |comment|
      comment.update_column(:cached_data, comment.as_json)
    end
  end
end
