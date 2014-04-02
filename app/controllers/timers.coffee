Timer = require '../models/timer'
updateDurationFromTimers = require '../interactors/update_duration_from_timers'

module.exports =
  index: (req, res) ->
    params = Timer.params req.query
    console.log 'params are', params
    Timer.find(params).exec().then((timers) ->
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

      updateDurationFromTimers(timer.taskId).then ->
        res.send timer.serialize()

  update: (req, res) ->
    params = Timer.deserialize req.body.timer
    Timer.findByIdAndUpdate(req.param('timerId'), params).exec().then (timer) ->
      updateDurationFromTimers(timer.taskId)
    .then ->
      res.send timer.serialize()

