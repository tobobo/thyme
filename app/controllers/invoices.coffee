module.exports = (app) ->
  Invoice = require('../models/invoice') app
  
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

      res.send invoice.serialize()


