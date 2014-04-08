module.exports = (app) ->
  Invoice = require('../models/invoice')

  saveInvoiceAndCreateFile = require('../interactors/save_invoice_and_create_file') app

  index: (req, res) ->
    params = Invoice.params req.query
    Invoice.find(params).exec().then (invoices) =>
      res.send Invoice.serialize(invoices)
    , (error) =>
      res.send JSON.stringify
        meta:
          error: error

  show: (req, res) ->
    Invoice.findById(req.param('invoiceId')).exec().then (invoice) =>
      res.send invoice.serialize()

  new: (req, res) ->
    params = Invoice.params req.body.invoice
    saveInvoiceAndCreateFile(new Invoice(params)).then (invoice) =>
      res.send invoice.serialize()
    , (error) =>
      res.send JSON.stringify
        meta:
          error: error
