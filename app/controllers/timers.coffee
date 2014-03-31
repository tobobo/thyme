Timer = require '../models/timer'

module.exports =
  index: (req, res) ->
    Timer.find
      taskId: req.body.taskId
    .exec().then((timers) ->
      res.send Timer.serialize(timers)
    , (error) ->
      res.send
        meta:
          error: "Something went wrong"
    )

