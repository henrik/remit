require "rails_helper"

describe CommitSerializer, "#as_json" do
  let(:commit) { build(:commit, created_at: Time.now) }

  let(:serializer) { CommitSerializer.new(commit) }

  it "camelizes keys" do
    expect(serializer.as_json.keys).to include(:authorName)
  end
end
