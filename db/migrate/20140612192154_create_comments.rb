class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :payload

      t.timestamps
    end
  end
end
