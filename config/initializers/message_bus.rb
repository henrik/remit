if ENV["REDISCLOUD_URL"]
  MessageBus.redis_config = { url: ENV["REDISCLOUD_URL"], namespace: "messagebus" }
end
