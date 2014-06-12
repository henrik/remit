class AddGithubIdToComments < ActiveRecord::Migration
  def up
    add_column :comments, :github_id, :integer, null: true
    add_index :comments, :github_id, unique: true

    Comment.find_each do |comment|
      comment.update_column(:github_id, comment.payload[:id])
    end

    change_column :comments, :github_id, :integer, null: false
  end

  def down
    remove_index :comments, :column => :github_id
    remove_column :comments, :github_id
  end
end
