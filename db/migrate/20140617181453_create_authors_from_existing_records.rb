class CreateAuthorsFromExistingRecords < ActiveRecord::Migration
  def up
    Commit.find_each do |commit|
      payload = commit.payload.fetch(:author)

      author = Author.create_or_update_from_payload(
        name: payload.fetch(:name),
        email: payload.fetch(:email),
        username: payload[:username],
      )

      commit.update_attribute(:author_id, author.id)
    end

    Comment.find_each do |comment|
      author_username = comment.payload.fetch(:user).fetch(:login)

      author = Author.create_or_update_from_payload(
        username: author_username,
      )

      comment.update_attribute(:author_id, author.id)
    end

    change_column :commits, :author_id, :integer, null: false
    change_column :comments, :author_id, :integer, null: false
  end

  def down
  end
end
