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
    data = params[:comment]

    comment = Comment.where(github_id: data[:id]).first_or_initialize
    comment.payload = data
    comment.save!

    render text: "Thanks!"
  end

  def store_commits
    data_list = params[:commits]

    data_list.each do |data|
      data = data.merge(
        repository: params[:repository],
        pusher: params[:pusher],
      )

      commit = Commit.where(sha: data[:id]).first_or_initialize
      commit.payload = data
      commit.save!
    end

    render text: "Thanks!"
  end
end
