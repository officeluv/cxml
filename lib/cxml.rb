# require 'cxml/version'
require 'cxml/errors'
require 'time'
require 'nokogiri'
require 'digest'
require 'cxml/invoice/invoice_generator'
require 'cxml/invoice/invoice_header'
require 'cxml/invoice/invoice_request'
require 'cxml/invoice/invoice_detail_order'
require 'cxml/invoice/invoice_detail_summary'
require 'cxml/invoice/invoice_distribution'

module CXML
  autoload :Protocol,                     'cxml/protocol'
  autoload :Document,                     'cxml/document'
  autoload :Header,                       'cxml/header'
  autoload :Credential,                   'cxml/credential'
  autoload :CredentialMac,                'cxml/credential_mac'
  autoload :Sender,                       'cxml/sender'
  autoload :Status,                       'cxml/status'
  autoload :Request,                      'cxml/request'
  autoload :Response,                     'cxml/response'
  autoload :Parser,                       'cxml/parser'
  autoload :PunchOutSetupRequest,         'cxml/punch_out_setup_request'
  autoload :PunchOutSetupResponse,        'cxml/punch_out_setup_response'
  autoload :PunchOutOrderMessage,         'cxml/punch_out_order_message'
  autoload :PunchOutOrderMessageHeader,   'cxml/punch_out_order_message_header'
  autoload :ItemId,                       'cxml/item_id'
  autoload :ItemIn,                       'cxml/item_in'
  autoload :ItemOut,                      'cxml/item_out'
  autoload :ItemDetail,                   'cxml/item_detail'
  autoload :Money,                        'cxml/money'
  autoload :Contact,                      'cxml/contact'
  autoload :Extrinsic,                    'cxml/extrinsic'
  autoload :OrderRequest,                 'cxml/order_request'
  autoload :OrderRequestHeader,           'cxml/order_request_header'
  autoload :Address,                      'cxml/address'
  autoload :Distribution,                 'cxml/distribution'
  autoload :Accounting,                   'cxml/accounting'
  autoload :Segment,                      'cxml/segment'
  autoload :InvoiceGenerator,             'cxml/invoice/invoice_generator'
  autoload :InvoiceHeader,                'cxml/invoice/invoice_header'
  autoload :InvoiceRequest,               'cxml/invoice/invoice_request'
  autoload :InvoiceDetailOrder,           'cxml/invoice/invoice_detail_order'
  autoload :InvoiceDetailSummary,         'cxml/invoice/invoice_detail_summary'
  autoload :InvoiceDistribution,          'cxml/invoice/invoice_distribution'

  def self.parse(str)
    CXML::Parser.new.parse(str)
  end

  def self.builder
    Nokogiri::XML::Builder.new(:encoding => "UTF-8")
  end
end
