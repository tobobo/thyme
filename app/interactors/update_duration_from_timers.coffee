RSVP = require 'rsvp'

Task = require '../models/task'
Timer = require '../models/timer'

module.exports = (taskId) ->
  Timer.find
    taskId: taskId
  .exec().then (timers) ->
    duration = timers.map((timer) -> timer.getDuration()).reduce (a, b) ->
      a + b
    , 0
    Task.findByIdAndUpdate taskId,
      duration: duration
    .exec()
  .then (task) ->
    new RSVP.Promise (resolve, reject) ->
      resolve true
