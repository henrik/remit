require "rails_helper"

describe Comment, ".create_or_update_from_payload" do
  it "creates a record with the payload and a github_id" do
    comment = Comment.create_or_update_from_payload(
      id: 123,
      body: "Hi.",
    )

    expect(comment).to be_persisted
    expect(comment.github_id).to eq 123
    expect(comment.payload[:body]).to eq "Hi."
  end

  it "updates an old record if the id is not new" do
    comment = Comment.create_or_update_from_payload(
      id: 123,
      body: "Hi.",
    )

    Comment.create_or_update_from_payload(
      id: 123,
      body: "Bye.",
    )

    comment.reload
    expect(comment.github_id).to eq 123
    expect(comment.payload[:body]).to eq "Bye."
  end
end

describe Comment, "#as_json" do
  let(:comment) {
    Comment.new(payload: {
      body: "Yo.",
      user: { login: "henrik" },
    })
  }

  it "includes the desired attributes" do
    expect(comment.as_json).to include({
      body: "Yo.",
      sender_name: "henrik",
    }.stringify_keys)
  end
end
