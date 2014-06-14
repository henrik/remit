require "rails_helper"

describe "Receiving GitHub payloads by webhook" do
  before do
    Pusher.app_id = "123"
    Pusher.key    = "abc"
    Pusher.secret = "def"
  end

  it "handles pings zenfully" do
    post "/github_webhook",
      { zen: "Yo.", hook_id: 123 },
      { "X-Github-Event" => "ping" }

    expect(response).to be_success
  end

  it "stores commit comments" do
    post "/github_webhook",
      { comment: attributes_for(:comment, body: "Hi.")[:payload] },
      { "X-Github-Event" => "commit_comment" }

    expect(response).to be_success

    comment = Comment.last!
    expect(comment.payload[:body]).to eq "Hi."
  end

  it "stores commits" do
    post "/github_webhook",
      {
        commits: [
          FactoryGirl.commit_payload(sha: "faa"),
          FactoryGirl.commit_payload(sha: "aaf"),
        ],
        repository: { name: "myrepo" },
        pusher: { name: "mypusher" },
        ref: "refs/heads/master",
      },
      { "X-Github-Event" => "push" }

    expect(response).to be_success

    expect(Commit.count).to eq 2

    commit = Commit.first!
    expect(commit.sha).to eq "faa"
    expect(commit.payload[:repository][:name]).to eq "myrepo"
  end
end
