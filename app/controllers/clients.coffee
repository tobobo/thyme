Client = require '../models/client'

module.exports =
  index: (req, res) ->
    params = Client.params req.query
    Client.find(params).exec().then (clients) ->
      res.send Client.serialize(clients)
    , (error) ->
      res.send
        meta:
          error: "Something went wrong"

  show: (req, res) ->
    Client.findById(req.param('clientId')).exec().then (client) ->
      res.send client.serialize()

  new: (req, res) ->
    params = Client.params req.body.client
    newClient = new Client(params)
    newClient.save (error, client) ->
      if error
        res.statusCode = 422
        res.send JSON.stringify
          meta:
            error: error
        return

      res.send client.serialize()

  update: (req, res) ->
    params = Client.params req.body.client
    Client.findByIdAndUpdate(req.param('clientId'), params).exec().then (client) ->
      res.send client.serialize()
