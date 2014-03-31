Client = require '../models/client'

module.exports =
  index: (req, res) ->
    Client.find().exec().then((clients) ->
      res.send Client.serialize(clients)
    , (error) ->
      res.send
        meta:
          error: "Something went wrong"
    )

  new: (req, res) ->
    params = Client.params req.body.client
    new Client(params).save (error, client) ->
      if error
        res.send 
          meta:
            error: error
        return
      
      res.send client.serialize()


