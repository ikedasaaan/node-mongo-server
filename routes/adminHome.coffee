express = require 'express'
router = express.Router()

# GET home page. 
router.get "/adminHome", (req, res) ->
  res.render "adminHome"
  return

module.exports = router
