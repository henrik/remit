class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  force_ssl if: :production?
  before_filter :require_auth_key

  private

  def require_auth_key
    return unless production?

    raise "AUTH_KEY must be present in production. Please see README." unless ENV["AUTH_KEY"]

    # Remember auth_key in the session so you don't have to provide it with every single request.
    # A changed AUTH_KEY will expire your session.
    if session[:auth_key] == ENV["AUTH_KEY"] || params[:auth_key] == ENV["AUTH_KEY"]
      session[:auth_key] = ENV["AUTH_KEY"]
    else
      render status: 401, text: "Not authorized! Did you forget to provide auth_key in the URL?"
    end
  end

  def production?
    Rails.env.production?
  end
end
