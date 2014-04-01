mongoose = require 'mongoose'

taskSchema = new mongoose.Schema
  name:
    type: String
    required: true
  clientId:
    type: String
    required: true

taskSchema.methods.serializeToObj = ->
  id: @id
  name: @name
  clientId: @clientId

taskSchema.methods.serialize = (meta) ->
  task: @serializeToObj()
  meta: meta

Task = mongoose.model 'Task', taskSchema

Task.serialize = (tasks, meta) ->
  tasks: tasks.map (task) -> task.serializeToObj()
  meta: meta

Task.deserialize = (params) ->
  name: params.name
  clientId: params.clientId

Task.params = (params) ->
  result = {}
  for p, v of this.deserialize params
    if v? then result[p] = v
  result


module.exports = Task
