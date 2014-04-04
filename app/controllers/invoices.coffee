module.exports = (app) ->
  Invoice = require('../models/invoice')

  saveInvoiceAndCreateFile = require('../interactors/save_invoice_and_create_file') app

  show: (req, res) ->
    Invoice.findById(req.param('invoiceId')).then (invoice) =>
      res.send invoice.serialize()

  new: (req, res) ->
    params = Invoice.deserialize req.body.invoice
    saveInvoiceAndCreateFile(new Invoice(params)).then (invoice) =>
      res.send invoice.serialize()
    , (error) =>
      res.send JSON.stringify
        meta:
          error: error


