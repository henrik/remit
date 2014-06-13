class AddCommitShaToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commit_sha, :string, null: true
    add_index :comments, :commit_sha

    Comment.find_each do |comment|
      comment.update_column(:commit_sha, comment.payload[:commit_id])
    end

    change_column :comments, :commit_sha, :string, null: false
  end
end
