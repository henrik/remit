require "rails_helper"

describe "Receiving GitHub payloads by webhook" do
  it "handles pings zenfully" do
    post "/github_webhook",
      { zen: "Yo.", hook_id: 123 },
      { "X-Github-Event" => "ping" }

    expect(response).to be_success
  end

  it "stores commit comments and pushes an event" do
    expect_push "comment_updated", { comment: a_string_including("Hi.") }

    post "/github_webhook",
      { comment: attributes_for(:comment, body: "Hi.")[:payload] },
      { "X-Github-Event" => "commit_comment" }

    expect(response).to be_success

    comment = Comment.last!
    expect(comment.payload[:body]).to eq "Hi."
  end

  it "stores commits" do
    expect_push "commits_updated", { commits: a_string_including("faa") }

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

  private

  def expect_push(event, hash)
    pusher_instance = double(:pusher_instance)
    expect(Pusher).to receive(:[]).with("the_channel").and_return(pusher_instance)
    expect(pusher_instance).to receive(:trigger).with(event, hash)
  end
end
