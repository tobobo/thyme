mongoose = require 'mongoose'

timerSchema = new mongoose.Schema
  name:
    startTime: Date
    endTime: Date
    running:
      type: Boolean
      default: false

timerSchema.methods.serializeToObj = ->
  id: @id
  name: @name
  timerId: @timerId

timerSchema.methods.serialize = (meta) ->
  timer: @serializeToObj()
  meta: meta

Timer = mongoose.model 'Timer', timerSchema

Timer.serialize = (tasks, meta) ->
  timers: tasks.map (client) -> timer.serializeToObj()
  meta: meta


module.exports = Timer
