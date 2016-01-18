conf = require("config")

exports.connect = (logger) ->

  redis = require("haredis")

  nodes = undefined
  redisClient = undefined
  nodes = [
    conf.redis.host + ":" + conf.redis.port
  ]

  redisClient = redis.createClient(nodes)

  redisClient.select conf.redis.db

  redisClient.on "error", (err) ->
    console.log "Redis Error!" + err.stack
    logger.error "Redis Error!" + err.stack

  redisClient.on "connect", ->
    console.log "Redis redisClient connected!"
    logger.info "Redis redisClient connected!"

  return redisClient

