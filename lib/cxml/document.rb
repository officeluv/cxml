# frozen_string_literal: true

require 'time'

module CXML
  class Document
    attr_accessor :header
    attr_accessor :message
    attr_accessor :payload_id
    attr_accessor :request
    attr_accessor :response
    attr_accessor :timestamp
    attr_accessor :version
    attr_accessor :xml_lang

    def initialize(version: nil, payload_id: nil, xml_lang: nil, timestamp: nil, header: nil, request: nil, response: nil, message: nil)
      @version = version
      @payload_id = payload_id
      @xml_lang = xml_lang
      @timestamp = Time.now.utc.iso8601
      @timestamp = Time.parse(timestamp) if timestamp
      @header = CXML::Header.new(header) if header
      @request = CXML::Request.new(request) if request
      @response = CXML::Response.new(response) if response
      @message = CXML::Message.new(message) if message
    end

    # Check if document is request
    # @return [Boolean]
    def request?
      !request.nil?
    end

    # Check if document is a response
    # @return [Boolean]
    def response?
      !response.nil?
    end

    # Check if document is a message
    # @return [Boolean]
    def message?
      !message.nil?
    end

    def build_attributes
      {
        'version' => version,
        'payloadID' => payload_id,
        'timestamp' => timestamp,
        'xml:lang' => xml_lang
      }
    end

    def render
      node = CXML.builder
      node.doc.create_internal_subset(
        'cXML',
        nil,
        'http://xml.cxml.org/schemas/cXML/1.2.037/cXML.dtd'
      )
      node.cXML(build_attributes) do |doc|
        request&.render(doc)
        response&.render(doc)
        punch_out_order_message&.render(doc)
      end
      node
    end
  end
end
