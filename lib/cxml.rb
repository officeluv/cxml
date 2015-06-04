# require 'cxml/version'
require 'cxml/errors'
require 'time'
require 'nokogiri'

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
  autoload :ItemDetail,                   'cxml/item_detail'
  autoload :Money,                        'cxml/money'

  def self.parse(str)
    CXML::Parser.new.parse(str)
  end

  def self.builder
    Nokogiri::XML::Builder.new(:encoding => "UTF-8")
  end
end
