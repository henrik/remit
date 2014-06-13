class GithubWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    case request.headers["X-Github-Event"]
    when "ping"
      pong
    when "commit_comment"
      store_comment
    when "push"
      store_commits
    else
      render text: "Unhandled event.", status: 412
    end
  end

  private

  # http://developer.github.com/webhooks/#ping-event
  def pong
    render text: "Pong!"
  end

  # https://developer.github.com/v3/activity/events/types/#commitcommentevent
  # https://developer.github.com/v3/repos/comments/#list-commit-comments-for-a-repository
  def store_comment
    payload = params[:comment]
    Comment.create_or_update_from_payload(payload)
    render text: "Thanks!"
  end

  def store_commits
    payloads = params[:commits]

    payloads.each do |payload|
      Commit.create_or_update_from_payload(payload, params)
    end

    render text: "Thanks!"
  end
end
