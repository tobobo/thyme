Timer = require '../models/timer'

module.exports =
  index: (req, res) ->
    Timer.find
      taskId: req.query.taskId
    .exec().then((timers) ->
      res.send Timer.serialize(timers)
    , (error) ->
      console.log 'timer error'
      res.statusCode = 500
      res.send JSON.serialize
        meta:
          error: "Something went wrong"
    )


  new: (req, res) ->
    params = Timer.deserialize req.body.timer
    newTimer = new Timer(params)
    newTimer.save (error, timer) ->
      if error
        res.statusCode = 422
        res.send
          meta:
            error: error
        return
      res.send timer.serialize()
