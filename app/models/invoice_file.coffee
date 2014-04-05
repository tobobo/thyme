module.exports = (app) ->
  RSVP = require 'rsvp'
  fs = require 'fs'
  path = require 'path'

  class InvoiceFile
    constructor: (@invoice) ->
      @tmpPath = path.join app.config.dirname, "tmp/#{@invoice.id}.pdf"
      @relUrl = "files/invoices/#{@invoice.id}/#{@invoice.number}.pdf"
      @path = path.join app.config.dirname, @relUrl

    save: ->
      @createTmp().then =>
        @moveFile()

    createTmp: ->
      new RSVP.Promise (resolve, reject) =>
        app.phantom.createPage (page) =>
          page.setPaperSize
            format: 'letter'
          , =>
            page.setContent @invoice.html
            page.render @tmpPath, =>
              resolve @

    moveFile: ->
      new RSVP.Promise (resolve, reject) =>
        fs.readFile @tmpPath, (err, data) =>
          fs.writeFile @path, data, (err) =>
            resolve @

    url: -> "http://#{app.config.host}/#{@relUrl}"

