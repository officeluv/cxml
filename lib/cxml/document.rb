# frozen_string_literal: true

module CXML
  class Document < DocumentNode
    accessible_attributes %i[
      dtd
      payload_id
      timestamp
      version
      xml_lang
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

    def dtd
      @dtd ||= 'cXML'
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

    def from_xml(xml_string)
      initialize(Parser.new(data: xml_string).parse)
      self
    end

    def to_xml(doc = ox_doc)
      doc << to_element
      Ox.dump doc
    end

    def node_name
      'cXML'
    end

    private

    def dtd_url
      "http://xml.cxml.org/schemas/cXML/#{version}/#{dtd}.dtd"
    end

    def ox_doc
      doc = Ox::Document.new
      instruct = Ox::Instruct.new(:xml)
      instruct[:version] = '1.0'
      instruct[:encoding] = 'UTF-8'
      instruct[:standalone] = 'yes'
      doc << instruct
      doc << Ox::DocType.new("cXML SYSTEM \"#{dtd_url}\"")
      doc
    end
  end
end
