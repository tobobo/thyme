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

clientSchema.methods.serializeToObj = ->
  id: @id
  email: @email
  name: @name
  contact: @contact

clientSchema.methods.serialize = (meta) ->
  client: @serializeToObj()
  meta: meta

Client = mongoose.model 'Client', clientSchema

Client.deserialize = (params) ->
  name: params.name
  email: params.email
  contact: params.contact

Client.serialize = (clients, meta) ->
  clients: clients.map (client) -> client.serializeToObj()
  meta: meta


module.exports = Client
