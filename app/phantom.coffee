phantom = require 'phantom'

module.exports = (app) ->
  phantom.create (ph) ->
    console.log 'phantom.js started'
    app.phantom = ph
