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
    comment = Comment.create_or_update_from_payload(payload)

    push "comment_updated", comment: comment.as_json

    render text: "Thanks!"
  end

  def store_commits
    payloads = params[:commits]

    commits = payloads.map { |payload|
      Commit.create_or_update_from_payload(payload, params)
    }

    push "commits_updated", commits: commits.as_json

    render text: "Thanks!"
  end

  def push(event, hash)
    Pusher.trigger("the_channel", event, hash)
  end

  def require_auth_key
    unless ENV["WEBHOOK_KEY"]
      raise "WEBHOOK_KEY must be configured in production. Please see README."
    end

    unless params[:auth_key] == ENV["WEBHOOK_KEY"]
      render status: 401, text: "Not authorized! Did you forget to provide auth_key in the URL?"
    end
  end
end
