class MakeJsonPayloadNotNull < ActiveRecord::Migration
  def change
    change_column :commits, :json_payload, :text, null: false
  end
end
