require "rails_helper"

describe CommentSerializer, "#as_json" do
  let(:comment) {
    build(:comment,
      commit_sha: "faa",
      body: "Yo.",
      author: Author.new(username: "charlesbabbage"),
    )
  }

  let(:serializer) { CommentSerializer.new(comment) }

  it "includes the desired attributes" do
    expect(serializer.as_json).to include(
      body: "Yo.",
    )
  end

  it "camelizes keys" do
    expect(serializer.as_json.keys).to include(:authorName)
  end
end
