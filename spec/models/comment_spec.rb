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

describe Comment, "#resolved?" do
  it "is true if resolved_at is set" do
    comment = build(:comment, resolved_at: Time.now)
    expect(comment.resolved?).to be_truthy
  end
end

describe Comment, "#mark_as_resolved_by" do
  it "assigns resolved_at, resolved_by_author and persists the record" do
    comment = build(:comment, resolved_at: nil)

    comment.mark_as_resolved_by("charles@babbage.com")

    expect(comment).to be_persisted
    expect(comment.resolved_at).to be_present
    expect(comment.resolved_by_author.email).to eq "charles@babbage.com"
  end
end

describe Comment, "#mark_as_unresolved" do
  it "unassigns resolved attributes and persists the record" do
    comment = build(:comment,
      resolved_at: Time.now,
      resolved_by_author: Author.new,
    )

    comment.mark_as_unresolved

    expect(comment).to be_persisted
    expect(comment.resolved_at).to be_nil
    expect(comment.resolved_by_author).to be_nil
  end
end
