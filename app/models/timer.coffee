mongoose = require 'mongoose'

timerSchema = new mongoose.Schema
  name:
    startTime: Date
    endTime: Date
    running:
      type: Boolean
      default: false

Timer = mongoose.model 'Timer', timerSchema

Timer.schema.methods.serializeToObj = ->
  id: @id
  name: @name
  timerId: @timerId

Timer.schema.methods.serialize = (meta) ->
  timer: @serializeToObj()
  meta: meta

Timer.serialize = (tasks, meta) ->
  timers: tasks.map (client) -> timer.serializeToObj()
  meta: meta


module.exports = Timer
