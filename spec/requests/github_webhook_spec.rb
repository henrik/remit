require "rails_helper"

describe "Receiving GitHub payloads by webhook" do
  it "handles pings zenfully" do
    post "/github_webhook",
      { zen: "Yo.", hook_id: 123 },
      { "X-Github-Event" => "ping" }

    expect(response).to be_success
  end

  it "stores commit comments and pushes an event" do
    expect_push "comment_updated", { comment: a_hash_including("body" => "Hi.") }

    post "/github_webhook",
      { comment: FactoryGirl.comment_payload(body: "Hi.") },
      { "X-Github-Event" => "commit_comment" }

    expect(response).to be_success

    comment = Comment.last!
    expect(comment.payload[:body]).to eq "Hi."
  end

  it "stores commits and pushes an event" do
    expect_push "commits_updated", {
      commits: [
        a_hash_including("summary" => "hi" ),
        a_hash_including("summary" => "ho" ),
      ],
    }

    post "/github_webhook",
      {
        commits: [
          FactoryGirl.commit_payload(message: "hi"),
          FactoryGirl.commit_payload(message: "ho"),
        ],
        repository: { name: "myrepo", master_branch: "master" },
        ref: "refs/heads/master",
      },
      { "X-Github-Event" => "push" }

    expect(response).to be_success

    expect(Commit.count).to eq 2

    commit = Commit.first!
    expect(commit.summary).to eq "hi"
    expect(commit.payload[:repository][:name]).to eq "myrepo"
  end

  it "skips commits that are not on the master branch" do
    post "/github_webhook",
      {
        commits: [
          FactoryGirl.commit_payload,
        ],
        repository: { name: "myrepo", master_branch: "master" },
        ref: "refs/heads/mybranch",
      },
      { "X-Github-Event" => "push" }

    expect(response).to be_success

    expect(Commit.count).to be 0
  end

  private

  def expect_push(event, hash)
    expect(Pusher).to receive(:trigger).with("the_channel", event, hash).and_call_original
  end
end
