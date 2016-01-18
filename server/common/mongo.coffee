conf = require("config")

EcRevSchema = undefined
mongoose = undefined

exports.connect = (logger) ->

  mongoose = require 'mongoose'

  EcRevSchema = new mongoose.Schema(
    title: String
    body: String
  )
  
  mongoose.connect "mongodb://"+ conf.mongo.user + ":" + conf.mongo.pass + "@" + conf.mongo.host + ":" + conf.mongo.port + "/" + conf.mongo.db, (err) ->
    if err
      console.log err
      logger.error err
    else
      console.log "MongoDB connection success!"
      logger.info "MongoDB connection success!"
    return
  
  return mongoose


exports.getCollections = (colName) ->

  return mongoose.model(colName, EcRevSchema)

