class MigratePayloadData < ActiveRecord::Migration
  def change
    # json_payload will be used by exremit since it has trouble reading the regular payload
    Commit.find_each do |c|
      c.update_column(:json_payload, c.payload.to_json)
    end
  end
end
