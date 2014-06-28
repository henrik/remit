class UserAuthorization
  pattr_initialize :provided_auth_key, :session

  def authorize
    ensure_auth_key_is_defined_in_production
    return true unless expected_auth_key

    # Remember auth key in the session so you don't have to provide it with every single request.
    # A changed expected key will expire your session.
    if session[:auth_key] == expected_auth_key || provided_auth_key == expected_auth_key
      session[:auth_key] = expected_auth_key
      true
    else
      false
    end
  end

  private

  def ensure_auth_key_is_defined_in_production
    if Rails.env.production? && !expected_auth_key
      raise "AUTH_KEY must be configured in production. Please see README."
    end
  end

  def expected_auth_key
    ENV["AUTH_KEY"]
  end
end
