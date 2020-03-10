# frozen_string_literal: true

# require 'cxml/version'
require 'cxml/errors'
require 'time'
require 'nokogiri'

module CXML
  autoload :Accounting,                   'cxml/accounting'
  autoload :Address,                      'cxml/address'
  autoload :Contact,                      'cxml/contact'
  autoload :Credential,                   'cxml/credential'
  autoload :CredentialMac,                'cxml/credential_mac'
  autoload :Distribution,                 'cxml/distribution'
  autoload :Document,                     'cxml/document'
  autoload :Extrinsic,                    'cxml/extrinsic'
  autoload :Header,                       'cxml/header'
  autoload :Invoice,                      'cxml/invoice'
  autoload :ItemDetail,                   'cxml/item_detail'
  autoload :ItemId,                       'cxml/item_id'
  autoload :ItemIn,                       'cxml/item_in'
  autoload :ItemOut,                      'cxml/item_out'
  autoload :Money,                        'cxml/money'
  autoload :OrderRequest,                 'cxml/order_request'
  autoload :OrderRequestHeader,           'cxml/order_request_header'
  autoload :Parser,                       'cxml/parser'
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
  autoload :Status,                       'cxml/status'

  def self.parse(str)
    CXML::Parser.new.parse(str)
  end

  def self.builder
    Nokogiri::XML::Builder.new(encoding: 'UTF-8')
  end
end
