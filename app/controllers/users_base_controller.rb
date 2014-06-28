class UsersBaseController < ApplicationController
  private

  def require_auth_key
    authorization = UserAuthorization.new(params[:auth_key], session)
    authorization.authorize || render_auth_failure
  end

  def render_auth_failure
    render status: 401,
      text: "Not authorized! Did you forget to provide auth_key in the URL?"
  end
end
