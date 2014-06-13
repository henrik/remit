require "rails_helper"

describe Comment, ".create_or_update_from_payload" do
  it "creates a record with the payload and some attributes" do
    comment = Comment.create_or_update_from_payload(
      id: 123,
      commit_id: "faa",
      body: "Hi.",
    )

    expect(comment).to be_persisted
    expect(comment.github_id).to eq 123
    expect(comment.commit_sha).to eq "faa"
    expect(comment.payload[:body]).to eq "Hi."
  end

  it "updates an old record if the id is not new" do
    comment = Comment.create_or_update_from_payload(
      id: 123,
      commit_id: "faa",
      body: "Hi.",
    )

    Comment.create_or_update_from_payload(
      id: 123,
      commit_id: "faa",
      body: "Bye.",
    )

    comment.reload
    expect(comment.github_id).to eq 123
    expect(comment.payload[:body]).to eq "Bye."
  end
end

describe Comment, "#as_json" do
  let(:comment) {
    Comment.new(
      commit_sha: "faa",
      payload: {
        body: "Yo.",
        user: { login: "henrik" },
      },
    )
  }

  it "includes the desired attributes" do
    expect(comment.as_json).to include({
      body: "Yo.",
      sender_name: "henrik",
    }.stringify_keys)
  end
end

describe Comment, "#commit" do
  it "finds a related commit if there is one" do
    commit = Commit.create!(sha: "faa")
    comment = Comment.create!(github_id: 1, commit_sha: "faa")
    expect(comment.commit).to eq commit
  end

  it "returns nil if the commit is not stored" do
    comment = Comment.create!(github_id: 1, commit_sha: "faa")
    expect(comment.commit).to be_nil
  end
end
