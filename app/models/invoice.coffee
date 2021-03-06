mongoose = require 'mongoose'

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
  path:
    type: String
  fileUrl:
    type: String
  startDate:
    type: Date
  endDate:
    type: Date


invoiceSchema.methods.serializeToObj = ->
  id: @id
  number: @number
  clientId: @clientId
  html: @html
  path: @path
  createdAt: @createdAt
  fileUrl: @fileUrl
  startDate: @startDate
  endDate: @endDate
  
invoiceSchema.methods.serialize = (meta) ->
  invoice: @serializeToObj()
  meta: meta

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


module.exports = Invoice
