Timer = require '../models/timer'
updateDurationFromTimers = require '../interactors/update_duration_from_timers'

module.exports =
  index: (req, res) ->
    params = Timer.params req.query
    Timer.find(params).exec().then((timers) ->
      res.send Timer.serialize(timers)
    , (error) ->
      res.statusCode = 500
      res.send JSON.stringify
        meta:
          error: "Something went wrong"
    )


  new: (req, res) ->
    params = Timer.params req.body.timer
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

  delete: (req, res) ->
    Timer.findByIdAndRemove req.param('timerId')
    .exec().then (error) =>
      res.send
        meta:
          success: true

  update: (req, res) ->
    params = Timer.deserialize req.body.timer
    theTimer = null
    Timer.findByIdAndUpdate(req.param('timerId'), params).exec().then (timer) ->
      theTimer = timer
      updateDurationFromTimers(timer.taskId)
    .then ->
      res.send theTimer.serialize()

