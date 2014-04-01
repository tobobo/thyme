mongoose = require 'mongoose'
S = require 'string'

taskSchema = new mongoose.Schema
  name:
    type: String
    required: true
  slug:
    type: String
    required: true
  clientId:
    type: String
    required: true

taskSchema.methods.serializeToObj = ->
  id: @id
  name: @name
  slug: @slug
  clientId: @clientId

taskSchema.methods.serialize = (meta) ->
  task: @serializeToObj()
  meta: meta

taskSchema.pre 'validate', (next, done) ->
  if @name?
    @slug = S(@name).slugify()
  next()

Task = mongoose.model 'Task', taskSchema

Task.serialize = (tasks, meta) ->
  tasks: tasks.map (task) -> task.serializeToObj()
  meta: meta

Task.deserialize = (params) ->
  taskSchema.methods.serializeToObj.call params

Task.params = (params) ->
  result = {}
  for p, v of this.deserialize params
    if v? then result[p] = v
  result


module.exports = Task
