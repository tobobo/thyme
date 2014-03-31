Task = require '../models/task'

module.exports =
  index: (req, res) ->
    Task.find
      clientId: req.body.clientId
    .exec().then((tasks) ->
      res.send Task.serialize(tasks)
    , (error) ->
      res.send
        meta:
          error: "Something went wrong"
    )

