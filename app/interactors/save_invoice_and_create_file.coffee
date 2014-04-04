module.exports = (app) ->

  RSVP = require 'rsvp'

  Invoice = require('../models/invoice') app
  InvoiceFile = require('../models/invoice_file') app

  (invoice) ->
    new RSVP.Promise (resolve, reject) ->
      invoice.save (error, invoice) ->
        if error
          reject error
          return
        invoiceFile = new InvoiceFile(invoice)
        invoiceFile.save().then (invoiceFile) =>
          invoice.path = invoiceFile.path
          invoice.fileUrl = invoiceFile.url()
          invoice.save (error, invoice) ->
            if error
              reject error
              return
            resolve invoice
