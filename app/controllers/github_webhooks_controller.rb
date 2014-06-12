class GithubWebhooksController < ApplicationController
  def create
    case request.headers["X-Github-Event"]
    when "ping"
      # http://developer.github.com/webhooks/#ping-event
      handle_ping
    else
      render text: "Unhandled event.", status: 412
    end
  end

  private

  def handle_ping
    render text: "Pong!"
  end
end
