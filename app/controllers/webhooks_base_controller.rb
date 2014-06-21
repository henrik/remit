# This controller receives commits and comments from GitHub.

class WebhooksBaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def require_auth_key
    unless ENV["WEBHOOK_KEY"]
      if Rails.env.production?
        raise "WEBHOOK_KEY must be configured in production. Please see README."
      else
        return
      end
    end

    unless params[:auth_key] == ENV["WEBHOOK_KEY"]
      render status: 401, text: "Not authorized! Did you forget to provide auth_key in the URL?"
    end
  end
end
