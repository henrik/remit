class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  force_ssl if: :production?
  before_filter :require_auth_key

  private

  def production?
    Rails.env.production?
  end

  def require_auth_key
    raise "Implement me in subclasses."
  end
end
