require "rails_helper"

describe "Receiving GitHub payloads by webhook" do
  it "handles pings zenfully" do
    post "/github_webhook",
      { zen: "Yo.", hook_id: 123 },
      { "X-Github-Event" => "ping" }

    expect(response).to be_success
  end

  it "stores commit comments" do
    post "/github_webhook",
      { comment: { id: 1, body: "Hi." } },
      { "X-Github-Event" => "commit_comment" }

    expect(response).to be_success

    comment = Comment.last!
    expect(comment.payload[:body]).to eq "Hi."
  end

  it "updates commit comments if they're sent again" do
    post "/github_webhook",
      { comment: { id: 1, body: "Hi." } },
      { "X-Github-Event" => "commit_comment" }

    expect(Comment.count).to eq 1
    expect(Comment.find_by_github_id(1).payload[:body]).to eq "Hi."

    post "/github_webhook",
      { comment: { id: 2, body: "What's up?" } },
      { "X-Github-Event" => "commit_comment" }

    expect(Comment.count).to eq 2

    post "/github_webhook",
      { comment: { id: 1, body: "Bye." } },
      { "X-Github-Event" => "commit_comment" }

    expect(Comment.count).to eq 2
    expect(Comment.find_by_github_id(1).payload[:body]).to eq "Bye."
  end
end
