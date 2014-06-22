require "rails_helper"

describe Comment, ".create_or_update_from_payload" do
  it "creates a record with the payload and some attributes" do
    comment = Comment.create_or_update_from_payload(
      id: 123,
      commit_id: "faa",
      body: "Hi.",
      user: { login: "username" },
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
      user: { login: "username" },
    )

    Comment.create_or_update_from_payload(
      id: 123,
      commit_id: "faa",
      body: "Bye.",
      user: { login: "username" },
    )

    comment.reload
    expect(comment.github_id).to eq 123
    expect(comment.payload[:body]).to eq "Bye."
  end

  it "creates or updates an author record" do
    comment = Comment.create_or_update_from_payload(
      id: 123,
      commit_id: "faa",
      body: "Hi.",
      user: { login: "username" },
    )

    expect(comment.author.username).to eq "username"
  end
end

describe Comment, "#as_json" do
  let(:comment) {
    build(:comment,
      commit_sha: "faa",
      body: "Yo.",
      author: Author.new(username: "charlesbabbage"),
    )
  }

  it "includes the desired attributes" do
    expect(comment.as_json).to include(
      body: "Yo.",
      author_name: "charlesbabbage",
    )
  end
end

describe Comment, "#commit" do
  it "finds a related commit if there is one" do
    commit = create(:commit, sha: "faa")
    comment = create(:comment, commit_sha: "faa")
    expect(comment.commit).to eq commit
  end

  it "returns nil if the commit is not stored" do
    comment = create(:comment, commit_sha: "faa")
    expect(comment.commit).to be_nil
  end
end
