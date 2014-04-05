mongoose = require 'mongoose'
S = require 'string'

clientSchema = new mongoose.Schema
  name:
    type: String
    required: true
  slug:
    type: String
    unique: true
    required: true
  email:
    type: String
    required: true
    trim: true
    lowercase: true
  contact:
    type: String
  rate:
    type: Number
  invoicePrefix: String
  nextInvoice:
    type: Number
    default: 1

clientSchema.methods.serializeToObj = ->
  id: @id
  email: @email
  name: @name
  contact: @contact
  slug: @slug
  rate: @rate
  invoicePrefix: @invoicePrefix
  nextInvoice: @nextInvoice

clientSchema.methods.serialize = (meta) ->
  client: @serializeToObj()
  meta: meta

clientSchema.pre 'validate', (next, done) ->
  if @name?
    @slug = S(@name).slugify()
  next()

Client = mongoose.model 'Client', clientSchema

Client.deserialize = (params) ->
  clientSchema.methods.serializeToObj.call params

Client.params = (params) ->
  result = {}
  for p, v of this.deserialize params
    if v? then result[p] = v
  result

Client.serialize = (clients, meta) ->
  clients: clients.map (client) -> client.serializeToObj()
  meta: meta


module.exports = Client
