module.exports = (app) ->
  Invoice = require('../models/invoice') app
  InvoiceFile = require('../models/invoice_file') app

  show: (req, res) ->
    Invoice.findById(req.param('invoiceId')).then (invoice) =>
      res.send invoice.serialize()

  new: (req, res) ->
    params = Invoice.deserialize req.body.invoice
    newInvoice = new Invoice(params)
    newInvoice.save (error, invoice) ->
      if error
        res.statusCode = 422
        res.send JSON.stringify
          meta:
            error: error
        return

      file = new InvoiceFile(invoice)
      file.save().then =>
        res.send invoice.serialize()


