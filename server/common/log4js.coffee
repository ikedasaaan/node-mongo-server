conf = require("config")

exports.logger = () ->

  log4js = require 'log4js'

  log4js.configure './config/log4js_setting.json'

  logger = log4js.getLogger('system')

  logger.setLevel(conf.log4js.level);

  return logger

