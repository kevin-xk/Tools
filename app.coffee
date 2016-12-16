express = require 'express'
path = require 'path'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'

index = require './routes/index'

app = express()

#view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

#uncomment after placing your favicon in /public
app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: false }
app.use cookieParser()
app.use express.static path.join __dirname, 'public'
app.use '/scripts', express.static __dirname + '/node_modules/materialize-css/dist/'

app.use '/', index

#catch 404 and forward to error handler
app.use (req, res, next)->
  err = new Error('Not Found')
  err.status = 404
  next(err)

#error handler
app.use (err, req, res, next)->
  res.locals.message = err.message
  res.locals.error = req.app.get('env') is 'development' ? err : {}
#  render the error page
  res.status(err.status or 500)
  res.render('error')

module.exports = app
