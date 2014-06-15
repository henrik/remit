class AddReviewedAtToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :reviewed_at, :datetime, null: true
  end
end
