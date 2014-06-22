require "rails_helper"

describe CommentSerializer, "#as_json" do
  let(:comment) { build(:comment) }
  let(:serializer) { CommentSerializer.new(comment) }

  it "camelizes keys" do
    expect(serializer.as_json.keys).to include(:authorName)
  end
end
