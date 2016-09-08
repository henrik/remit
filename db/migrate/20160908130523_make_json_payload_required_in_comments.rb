class MakeJsonPayloadRequiredInComments < ActiveRecord::Migration
  def change
    change_column :comments, :json_payload, :text, null: false
  end
end
