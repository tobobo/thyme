mongoose = require 'mongoose'
S = require 'string'

clientSchema = new mongoose.Schema
  name:
    type: String
    unique: true
    required: true
  slug:
    type: String
    unique: true
    required: true
  email:
    type: String
    unique: true
    required: true
    trim: true
    lowercase: true
  contact:
    type: String

clientSchema.methods.serializeToObj = ->
  id: @id
  email: @email
  name: @name
  contact: @contact
  slug: @slug

clientSchema.methods.serialize = (meta) ->
  client: @serializeToObj()
  meta: meta

clientSchema.pre 'validate', (next, done) ->
  @slug = S(@name).slugify()
  next()
  done()

Client = mongoose.model 'Client', clientSchema

Client.deserialize = (params) ->
  name: params.name
  email: params.email
  contact: params.contact

Client.serialize = (clients, meta) ->
  clients: clients.map (client) -> client.serializeToObj()
  meta: meta


module.exports = Client
