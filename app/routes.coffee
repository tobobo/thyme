index = require './controllers/index'
clients = require './controllers/clients'
tasks = require './controllers/tasks'
timers = require './controllers/timers'

module.exports = (app) ->
  app.get '/', index

  app.get '/clients', clients.index
  app.post '/clients', clients.new
  app.get '/clients/:clientId', clients.show

  app.get '/tasks', tasks.index
  app.post '/tasks', tasks.new
  app.get '/tasks/:taskId', tasks.show

  app.get '/timers', timers.index
  app.post '/timers', timers.new
  app.put '/timers/:timerId', timers.update
  app.delete '/timers/:timerId', timers.delete
