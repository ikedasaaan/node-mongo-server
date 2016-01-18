express      = require 'express'
path         = require 'path'
favicon      = require 'serve-favicon'
morgan       = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
conf         = require 'config'
router       = require './server/common/router'
routes       = router()

app = express()

# view engine setup
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use morgan("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use require("less-middleware")(path.join(__dirname, "public"))
app.use (req, res, next) ->
  res.header "Pragma", "no-cache"
  res.header "Cache-Control", "private, no-cache, no-store, must-revalidate"
  res.header "Expires", "Mon, 01 Jan 1990 00:00:00 GMT"
  res.header "X-Frame-Options", "SAMEORIGIN"
  res.header "X-Content-Type-Options", "nosniff"
  res.header "X-XSS-Protection", "1; mode=block"
  next()
app.use express.static(path.join(__dirname, "public"))

app.use require("connect-livereload")()
app.use "/", routes

# ==========================================================
# Server Logic.
# ==========================================================
main = require './server/common/main'
main = main(app)

# ==========================================================
# error handling.
# ==========================================================

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error("Not Found")
  err.status = 404
  next err
  return

# error handlers

# development error handler
# will print stacktrace
if app.get("env") is "development"
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render "exError",
      message: err.message
      error: err

    return

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render "exError",
    message: err.message
    error: {}

  return

module.exports = app
