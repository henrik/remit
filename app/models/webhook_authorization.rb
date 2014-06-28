class WebhookAuthorization
  pattr_initialize :provided_auth_key

  def authorize
    ensure_auth_key_is_defined_in_production
    return true unless expected_auth_key

    provided_auth_key == expected_auth_key
  end

  private

  def ensure_auth_key_is_defined_in_production
    if Rails.env.production? && !expected_auth_key
      raise "WEBHOOK_KEY must be configured in production. Please see README."
    end
  end

  def expected_auth_key
    ENV["WEBHOOK_KEY"]
  end
end
