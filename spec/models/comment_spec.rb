require "rails_helper"

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
