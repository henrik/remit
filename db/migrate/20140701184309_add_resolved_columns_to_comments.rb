class AddResolvedColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :resolved_at, :datetime, null: true
    add_column :comments, :resolved_by_author_id, :integer, null: true
    add_index :comments, :resolved_by_author_id
  end
end
