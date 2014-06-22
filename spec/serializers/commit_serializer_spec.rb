require "rails_helper"

describe CommitSerializer, "#as_json" do
  it "builds a hash of properties" do
    commit = build(:commit, reviewed_at: Time.now, created_at: Time.now)
    serializer = CommitSerializer.new(commit)
    expect(serializer.as_json).to include(
      reviewed: true,
    )
  end
end
