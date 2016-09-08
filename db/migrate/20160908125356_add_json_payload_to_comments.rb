class AddJsonPayloadToComments < ActiveRecord::Migration
  def change
    # null: true until the existing data is migrated
    add_column :comments, :json_payload, :text, null: true
  end
end
