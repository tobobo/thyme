express = require 'express'
passport = require 'passport'
path = require 'path'
MongoStore = require('connect-mongo') express

module.exports = (app) ->
  app.use express.static('public')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser(app.config.session.cookie_secret)

  connection = app.db.connections[0]
  app.use express.session
    secret: app.config.session.secret
    store: new MongoStore
      collection: 'sessions'
      url: app.config.db.url
    , (db) ->
      console.log 'mongo store connected'
    cookie:
      maxAge: 60*60*1000
      domain: app.config.session.cookie_domain

  app.use (req, res, next) ->
    originValid = false
    for host in app.config.clients
      if host.test req.headers.origin
        originValid = true
        break
    if originValid
      res.header 'Access-Control-Allow-Origin', req.headers.origin
      res.header 'Access-Control-Allow-Credentials', true
      res.header 'Access-Control-Allow-Methods', 'POST, GET, PUT, DELETE, OPTIONS'
      res.header 'Access-Control-Allow-Headers', 'Content-Type'
    next()


  app.use passport.initialize()
  app.use passport.session()

  app.use '/files', express.static(path.join(app.config.dirname, 'files'))
