# This controller receives deployed notifications from Heroku.
# https://devcenter.heroku.com/articles/deploy-hooks#http-post-hook

class HerokuWebhooksController < WebhooksBaseController
  def create
    push_event "app_deployed", version: Remit.version
    render text: "Thanks!"
  end
end
