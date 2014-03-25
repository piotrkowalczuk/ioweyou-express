express = require 'express'
config = require './config'
expressValidator = require 'express-validator'
mailer = require 'express-mailer'
apn = require('./lib/apn').apn
validator = require './lib/validator'


app = exports.app = express()
app.set('title', 'I Owe YOU!')
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

app.use express.bodyParser()
app.use expressValidator({
  errorFormatter: validator.errorFormatter
})

mailer.extend app, config.mailer

#Controllers
require('./api/entry')(app)
require('./api/auth')(app)
require('./api/user')(app)
require('./api/userClient')(app)

#Events
require('./event/applePushNotificationsSubscriber')()