class UsersBaseController < ApplicationController
  before_filter :redirect_to_another_installation

  private

  def redirect_to_another_installation
    return unless ENV["REDIRECT_TO_OTHER_REMIT_URL"]
    return if params[:skip_redirect]

    redirect_to ENV["REDIRECT_TO_OTHER_REMIT_URL"]
  end

  def authorization
    UserAuthorization.new(params[:auth_key], session)
  end
end
