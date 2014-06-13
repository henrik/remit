require 'rails_helper'

describe Comment, "#as_json" do
  it "includes some attributes" do
    comment = Comment.new(id: 123)
    expect(comment.as_json).to include "id" => 123
  end

  it "excludes the payload" do
    comment = Comment.new(payload: { foo: "bar" })

    expect(comment.as_json).not_to have_key "payloay"
  end
end
