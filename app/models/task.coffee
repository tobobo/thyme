mongoose = require 'mongoose'

taskSchema = new mongoose.Schema
  name:
    type: String
    unique: true
    required: true

Task = mongoose.model 'Task', taskSchema

Task.schema.methods.serializeToObj = ->
  id: @id
  name: @name
  clientId: @clientId

Task.schema.methods.serialize = (meta) ->
  task: @serializeToObj()
  meta: meta

Task.serialize = (tasks, meta) ->
  tasks: tasks.map (client) -> client.serializeToObj()
  meta: meta


module.exports = Task
