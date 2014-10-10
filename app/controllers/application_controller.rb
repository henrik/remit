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
    authorization.authorize || render_auth_failure
  end

  def authorization
    raise "Implement me in subclasses."
  end

  def render_auth_failure
    render status: 401,
      text: "Not authorized! Did you forget to provide auth_key in the URL?"
  end

  def push_event(channel, data)
    MessageBus.publish(channel, data.as_json)
  end
end
