class AddReviewedByAuthorIdToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :reviewed_by_author_id, :integer
    add_index :commits, :reviewed_by_author_id
  end
end
