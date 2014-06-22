require "rails_helper"

describe CommentSerializer, "#as_json" do
  it "includes the desired attributes" do
    comment = build(:comment,
      commit_sha: "faa",
      body: "Yo.",
      author: Author.new(username: "charlesbabbage"),
    )

    serializer = CommentSerializer.new(comment)

    expect(serializer.as_json).to include(
      body: "Yo.",
      author_name: "charlesbabbage",
    )
  end
end
