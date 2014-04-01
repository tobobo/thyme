Task = require '../models/task'

module.exports =
  index: (req, res) ->
    params = Task.params req.query
    Task.find(params).exec().then (tasks) ->
      res.send Task.serialize(tasks)
    , (error) ->
      res.send
        meta:
          error: "Something went wrong"

  new: (req, res) ->
    params = Task.deserialize req.body.task
    console.log 'params are', params
    newTask = new Task(params)
    console.log 'new task is', newTask
    newTask.save (error, task) ->
      if error
        res.send
          meta:
            error: error
        return

      res.send task.serialize()
