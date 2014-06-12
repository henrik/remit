class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :sha, null: false
      t.text :payload, null: false

      t.timestamps
    end

    add_index :commits, :sha, unique: true

    # Forgot to do null: false on this one.
    change_column :comments, :payload, :text, null: false
  end
end
