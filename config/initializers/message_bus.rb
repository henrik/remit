url = ENV["REDISCLOUD_URL"]

if ENV["DEVBOX"]
  # Redis supports multiple databases, we normally use 0, but tests use 1 and up
  # so that they can use the same redis server but not collide with the regular database.
  database_number = Rails.env.test? ? 1 : 0
  url = "redis://127.0.0.1:#{`service_port redis`.chomp}/#{database_number}"
end

if url
  MessageBus.redis_config = { url: url, namespace: "messagebus" }
end
