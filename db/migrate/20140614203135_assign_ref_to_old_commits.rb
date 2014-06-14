class AssignRefToOldCommits < ActiveRecord::Migration
  def change
    Commit.find_each do |commit|
      # Let's assume they're all master.
      commit.payload[:ref] = "refs/heads/master"
      commit.save!
    end
  end
end
