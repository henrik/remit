# Adapted from https://github.com/tristandunn/pusher-fake/blob/master/lib/pusher-fake/cucumber.rb

# We'll run against a pusher-fake server: the values don't matter but they cannot be empty.
Pusher.app_id = "a"
Pusher.key    = "b"
Pusher.secret = "c"

# Use the same API key and secret as the live version.
PusherFake.configure do |configuration|
  configuration.app_id = Pusher.app_id
  configuration.key    = Pusher.key
  configuration.secret = Pusher.secret
end

# Set the host and port to the fake web server.
PusherFake.configuration.web_options.tap do |options|
  Pusher.host = options[:host]
  Pusher.port = options[:port]
end

# Start the fake socket and web servers.
fork { PusherFake::Server.start }.tap do |id|
  at_exit { Process.kill("KILL", id) }
end

RSpec.configure do |config|
  # Reset channels between scenarios.
  config.after(:each) do
    PusherFake::Channel.reset
  end
end
