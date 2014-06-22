require "rails_helper"

describe CommitSerializer, "#as_json" do
  let(:commit) { build(:commit, reviewed_at: Time.now, created_at: Time.now) }

  let(:serializer) { CommitSerializer.new(commit) }

  it "builds a hash of properties" do
    expect(serializer.as_json).to include(
      reviewed: true,
    )
  end

  it "camelizes keys" do
    expect(serializer.as_json.keys).to include(:authorName)
  end
end
