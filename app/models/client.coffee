mongoose = require 'mongoose'

clientSchema = new mongoose.Schema
  name:
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

Client = mongoose.model 'Client', clientSchema

Client.schema.methods.serializeToObj = ->
  id: @id
  email: @email

Client.schema.methods.serialize = (meta) ->
  client: @serializeToObj()
  meta: meta

Client.deserialize = (params) ->
  name: params.name
  contact: params.contact

Client.serialize = (clients, meta) ->
  clients: clients.map (client) -> client.serializeToObj()
  meta: meta


module.exports = Client
