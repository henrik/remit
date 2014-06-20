namespace :dev do
  desc "Send ENV['N'] (default: 1) fake commits by webhook"
  task :commits => :environment do
    count = ENV["N"].to_i.nonzero? || 1

    puts "Sending #{count} fake #{count == 1 ? "commit" : "commits"} to the webhook…"

    session = ActionDispatch::Integration::Session.new(Rails.application)
    response = session.post("/github_webhook",
      {
        commits: Array.new(count) { FactoryGirl.commit_payload },
        repository: { name: "fakerepo", master_branch: "master" },
        ref: "refs/heads/master",
      },
      { "X-Github-Event" => "push" },
    )

    puts "Done with response code #{response}"
  end

  desc "Send ENV['N'] (default: 1) fake comments by webhook"
  task :comments => :environment do
    count = ENV["N"].to_i.nonzero? || 1

    puts "Sending #{count} fake #{count == 1 ? "comment" : "comments"} to the webhook…"

    session = ActionDispatch::Integration::Session.new(Rails.application)

    responses = []
    count.times do
      # Must be unique.
      github_id = Comment.maximum(:github_id) + 1

      responses << session.post("/github_webhook",
        { comment: FactoryGirl.comment_payload(github_id: github_id) },
        { "X-Github-Event" => "commit_comment" },
      )
    end

    puts "Done with response codes #{responses.join(", ")}"
  end
end
