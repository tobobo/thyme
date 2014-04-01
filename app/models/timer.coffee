mongoose = require 'mongoose'

timerSchema = new mongoose.Schema
  taskId: String
  startTime: Date
  endTime: Date
  running:
    type: Boolean
    default: false

timerSchema.methods.serializeToObj = ->
  id: @id
  startTime: @startTime
  endTime: @endTime
  running: @running
  taskId: @taskId

timerSchema.methods.serialize = (meta) ->
  JSON.stringify
    timer: @serializeToObj()
    meta: meta

Timer = mongoose.model 'Timer', timerSchema

Timer.serialize = (timers, meta) ->
  JSON.stringify
    timers: timers.map (timer) -> timer.serializeToObj()
    meta: meta

Timer.deserialize = (params) ->
  timerSchema.methods.serializeToObj.call params

module.exports = Timer
