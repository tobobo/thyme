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

  show: (req, res) ->
    Task.findById(req.param('taskId')).exec().then (task) ->
      res.send task.serialize()

  new: (req, res) ->
    params = Task.deserialize req.body.task
    newTask = new Task(params)
    newTask.save (error, task) ->
      if error
        res.statusCode = 422
        res.send
          meta:
            error: error
        return

      res.send task.serialize()
