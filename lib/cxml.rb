# frozen_string_literal: true

# require 'cxml/version'
require('cxml/errors')
require('time')
require('nokogiri')
require('logger')

module CXML
  autoload :Accounting,                   'cxml/accounting'
  autoload :Address,                      'cxml/address'
  autoload :BillTo,                       'cxml/bill_to'
  autoload :BrowserFormPost,              'cxml/browser_form_post'
  autoload :Charge,                       'cxml/charge'
  autoload :Classification,               'cxml/classification'
  autoload :ConfirmationHeader,           'cxml/confirmation_header'
  autoload :ConfirmationItem,             'cxml/confirmation_item'
  autoload :ConfirmationRequest,          'cxml/confirmation_request'
  autoload :ConfirmationStatus,           'cxml/confirmation_status'
  autoload :Contact,                      'cxml/contact'
  autoload :Country,                      'cxml/country'
  autoload :Credential,                   'cxml/credential'
  autoload :CredentialMac,                'cxml/credential_mac'
  autoload :Description,                  'cxml/description'
  autoload :Distribution,                 'cxml/distribution'
  autoload :Document,                     'cxml/document'
  autoload :DocumentNode,                 'cxml/document_node'
  autoload :DocumentReference,            'cxml/document_reference'
  autoload :Email,                        'cxml/email'
  autoload :Extrinsic,                    'cxml/extrinsic'
  autoload :From,                         'cxml/from'
  autoload :Header,                       'cxml/header'
  autoload :Invoice,                      'cxml/invoice'
  autoload :ItemDetail,                   'cxml/item_detail'
  autoload :ItemId,                       'cxml/item_id'
  autoload :ItemIn,                       'cxml/item_in'
  autoload :ItemOut,                      'cxml/item_out'
  autoload :Message,                      'cxml/message'
  autoload :Money,                        'cxml/money'
  autoload :Name,                         'cxml/name'
  autoload :OrderReference,               'cxml/order_reference'
  autoload :OrderRequest,                 'cxml/order_request'
  autoload :OrderRequestHeader,           'cxml/order_request_header'
  autoload :Parser,                       'cxml/parser'
  autoload :PostalAddress,                'cxml/postal_address'
  autoload :Protocol,                     'cxml/protocol'
  autoload :PunchOutOrderMessage,         'cxml/punch_out_order_message'
  autoload :PunchOutOrderMessageHeader,   'cxml/punch_out_order_message_header'
  autoload :PunchOutSetupRequest,         'cxml/punch_out_setup_request'
  autoload :PunchOutSetupResponse,        'cxml/punch_out_setup_response'
  autoload :Request,                      'cxml/request'
  autoload :Response,                     'cxml/response'
  autoload :Segment,                      'cxml/segment'
  autoload :Sender,                       'cxml/sender'
  autoload :ShipTo,                       'cxml/ship_to'
  autoload :StartPage,                    'cxml/start_page'
  autoload :State,                        'cxml/state'
  autoload :Status,                       'cxml/status'
  autoload :SupplierSetup,                'cxml/supplier_setup'
  autoload :To,                           'cxml/to'
  autoload :Total,                        'cxml/total'
  autoload :UnitPrice,                    'cxml/unit_price'

  def self.parse(str)
    CXML::Parser.new.parse(str)
  end

  def self.builder
    Nokogiri::XML::Builder.new(encoding: 'UTF-8')
  end

  def self.configure
    yield(self)
  end

  def self.logger
    return @logger if @logger

    @logger ||= Logger.new(STDOUT)
    @logger.level = :warn
    @logger
  end

  def self.logger=(new_logger)
    @logger = new_logger
  end
end
