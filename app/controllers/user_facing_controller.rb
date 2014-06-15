class UserFacingController < ApplicationController
  private

  def require_auth_key
    expected_key = ENV["AUTH_KEY"]

    raise "AUTH_KEY must be configured in production. Please see README." unless expected_key

    # Remember auth key in the session so you don't have to provide it with every single request.
    # A changed expected key will expire your session.
    if session[:auth_key] == expected_key || params[:auth_key] == expected_key
      session[:auth_key] = expected_key
    else
      render status: 401, text: "Not authorized! Did you forget to provide auth_key in the URL?"
    end
  end
end
