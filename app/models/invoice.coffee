module.exports = (app) ->

  mongoose = require 'mongoose'
  phantom = require 'phantom'

  invoiceSchema = new mongoose.Schema
    number:
      type: String
    clientId:
      type: String
      required: true
    html:
      type: String
    createdAt:
      type: Date


  invoiceSchema.methods.serializeToObj = ->
    id: @id
    number: @number
    clientId: @clientId
    html: @html

  invoiceSchema.methods.serialize = (meta) ->
    client: @serializeToObj()
    meta: meta

  invoiceSchema.pre 'save', (next, done) ->
    app.phantom.createPage (page) =>
      page.setPaperSize
        format: 'letter'
      , =>
        page.setContent @html
        page.render 'tmp/invoice.pdf'
        next()

  Invoice = mongoose.model 'Invoice', invoiceSchema

  Invoice.deserialize = (params) ->
    invoiceSchema.methods.serializeToObj.call params

  Invoice.params = (params) ->
    result = {}
    for p, v of this.deserialize params
      if v? then result[p] = v
    result

  Invoice.serialize = (invoices, meta) ->
    invoices: invoices.map (invoice) -> invoice.serializeToObj()
    meta: meta


  Invoice
