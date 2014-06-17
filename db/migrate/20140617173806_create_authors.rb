class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name, null: true
      t.string :email, null: true
      t.string :username, null: true

      t.timestamps
    end

    add_column :commits, :author_id, :integer, null: true
    add_column :comments, :author_id, :integer, null: true
    add_index :commits, :author_id
    add_index :comments, :author_id
  end
end
