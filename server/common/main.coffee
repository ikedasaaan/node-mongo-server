conf = require("config")

module.exports = (app) ->

  # ==========================================================
  # log4js Setting.
  # ==========================================================
  log4js = require './log4js'
  logger = log4js.logger()

  # ==========================================================
  # labels Setting.
  # ==========================================================
  label = require './labels'
  labels = label.setLabels()

  # ==========================================================
  # Redis Setting.
  # ==========================================================
  redis = require './redis'
  redisClient = redis.connect(logger)
  
  # ==========================================================
  # MongoDB Setting.
  # ==========================================================
  mongo = require './mongo'
  mongoose = mongo.connect(logger)
  
  # Set collections.
  Users = mongo.getCollections("Users")

  # ==========================================================
  # logic require.
  # ==========================================================
  login = require './login'

  # ==========================================================
  # POST.
  # ==========================================================
  app.post "/", (req, res) ->
    login.login req, res, logger, redisClient, mongoose, Users, labels, () ->

  # ==========================================================
  # Socket Server..
  # ==========================================================
  ws = require './websocket'
  io = ws.connect(logger)
