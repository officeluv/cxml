# frozen_string_literal: true

require('time')

module CXML
  class Document < DocumentNode
    accessible_attributes %i[
      version
      payload_id
      xml_lang
      timestamp
    ]
    accessible_nodes %i[
      header
      message
      request
      response
    ]

    def initialize_timestamp(value)
      @timestamp = Time.parse(value)
    end

    def timestamp
      @timestamp ||= Time.now.utc
    end

    def version
      @version ||= '1.2.037'
    end

    def from_xml(xml_string)
      initialize(Parser.new.parse(xml_string))
      self
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

    def render
      node = CXML.builder
      node.doc.create_internal_subset(
        'cXML',
        nil,
        "http://xml.cxml.org/schemas/cXML/#{version}/cXML.dtd"
      )
      node.cXML(node_attributes) do |doc|
        header&.render(doc)
        request&.render(doc)
        response&.render(doc)
        message&.render(doc)
      end
      node
    end
  end
end
