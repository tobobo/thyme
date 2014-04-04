mongoose = require 'mongoose'

module.exports = (app) ->

  reconnectTimer = 1

  mongoose.connection.on 'open', ->
    console.log 'mongo connected'
    reconnectTimer = 1

  mongoose.connection.on 'error', (err) ->
    console.log 'mongo error', err

  mongoose.connection.on 'disconnected', ->
    console.log "mongo disconnected. reconnecting in #{reconnectTimer} second#{if reconnectTimer > 1 then 's' else ''}..."
    setTimeout ->
      unless reconnectTimer > 30
        reconnectTimer *= 2
      connect()
    , reconnectTimer*1000

  mongoose.connect app.config.db.url

  mongoose
