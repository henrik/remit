class UserFacingController < ApplicationController
  private

  def require_auth_key
    authorization.authorize || render_auth_failure
  end

  def render_auth_failure
    render status: 401, text: "Not authorized! Did you forget to provide auth_key in the URL?"
  end

  def authorization
    Authorization.new(session, params)
  end
end
