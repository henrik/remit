class AddCachedDataToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :cached_data, :text

    Commit.find_each do |commit|
      commit.update_column(:cached_data, commit.as_json)
    end
  end
end
