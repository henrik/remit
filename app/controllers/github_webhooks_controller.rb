class GithubWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    case request.headers["X-Github-Event"]
    when "ping"
      pong
    when "commit_comment"
      store_comment
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
    data = params[:comment]

    comment = Comment.create!(
      payload: data,
    )

    render text: "Thanks!"
  end
end
