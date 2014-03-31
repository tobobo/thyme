mongoose = require 'mongoose'

taskSchema = new mongoose.Schema
  name:
    type: String
    unique: true
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
  tasks: tasks.map (client) -> client.serializeToObj()
  meta: meta


module.exports = Task
