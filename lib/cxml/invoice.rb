# frozen_string_literal: true

module CXML
  # contact object within punchout setup request
  module Invoice
    autoload :InvoiceDetailItem,              'cxml/invoice/invoice_detail_item'
    autoload :InvoiceDetailLineItemReference, 'cxml/invoice/invoice_detail_line_item_reference'
    autoload :InvoiceDetailOrder,           'cxml/invoice/invoice_detail_order'
    autoload :InvoiceDetailSummary,         'cxml/invoice/invoice_detail_summary'
    autoload :InvoiceDistribution,          'cxml/invoice/invoice_distribution'
    autoload :InvoiceGenerator,             'cxml/invoice/invoice_generator'
    autoload :InvoiceHeader,                'cxml/invoice/invoice_header'
    autoload :InvoiceRequest,               'cxml/invoice/invoice_request'
    autoload :InvoiceTaxes,                 'cxml/invoice/invoice_taxes'
  end
end
