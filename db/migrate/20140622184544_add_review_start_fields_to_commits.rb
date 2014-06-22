class AddReviewStartFieldsToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :review_started_at, :datetime, null: true
    add_column :commits, :review_started_by_author_id, :integer, null: true

    add_index :commits, :review_started_by_author_id
  end
end
