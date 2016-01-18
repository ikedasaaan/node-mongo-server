conf = require("config")

exports.setLabels = () ->

  # index ログイン画面
  labels = []
  labels['LAB_01_001'] = conf.LAB.LAB_01_001
  labels['LAB_01_002'] = conf.LAB.LAB_01_002
  labels['LAB_01_003'] = conf.LAB.LAB_01_003
  labels['PLH_01_001'] = conf.LAB.PLH_01_001
  labels['PLH_01_002'] = conf.LAB.PLH_01_002

  return labels

