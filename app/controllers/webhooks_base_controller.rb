class WebhooksBaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def require_auth_key
    authorization = WebhookAuthorization.new(params[:auth_key])
    authorization.authorize || render_auth_failure
  end

  def render_auth_failure
    render status: 401,
      text: "Not authorized! Did you forget to provide auth_key in the URL?"
  end
end
