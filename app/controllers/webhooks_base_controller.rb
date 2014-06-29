class WebhooksBaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  private

  def authorization
    WebhookAuthorization.new(params[:auth_key])
  end
end
