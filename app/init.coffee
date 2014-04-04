phantom = require './phantom'
express = require 'express'
middleware = require './middleware'
routes = require './routes'

module.exports = (config) ->

  app = express()

  app.config = config

  db = require('./db') app.config

  phantom app

  middleware app.config, app, db

  routes app

  app
