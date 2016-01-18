express = require 'express'
router  = express.Router()

lab = require '../server/common/labels'
labels = lab.setLabels()

# GET index page. 
router.get "/", (req, res) ->
  res.render "index", labels
  return

module.exports = router
