Honeybadger.configure do |config|
  # Fall back to a fake key to avoid "API key not found" during Heroku asset compilation.
  config.api_key = ENV["HONEYBADGER_API_KEY"] || "fake_key"
end
