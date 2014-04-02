Timer = require '../models/timer'
updateDurationFromTimers = require '../interactors/update_duration_from_timers'

module.exports =
  index: (req, res) ->
    params = Timer.params req.query
    Timer.find(params).exec().then((timers) ->
      res.send Timer.serialize(timers)
    , (error) ->
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
    Timer.findByIdAndUpdate req.param('timerId'), params, (error, timer) ->
      updateDurationFromTimers(timer.taskId).then ->
        res.send timer.serialize()

  delete: (req, res) ->
    taskId = null
    Timer.findById(req.param('timerId')).exec().then (timer) ->
      console.log 'got timer', timer
      taskId = timer.taskId
      console.log 'here'
      timer.remove (error, timer) ->
        console.log 'timer remove cb'
        updateDurationFromTimers(taskId).then ->
          console.log 'updated duration'
          console.log 'serializing timer'
          res.send JSON.stringify
            timer: null

