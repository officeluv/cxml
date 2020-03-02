module CXML
  class Document
    attr_accessor :version
    attr_accessor :payload_id
    attr_accessor :timestamp
    attr_accessor :xml_lang

    attr_accessor :header
    attr_accessor :request
    attr_accessor :response
    attr_accessor :punch_out_order_message

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @version = data['version']
      @payload_id = data['payloadID'] || data['payload_id']
      @xml_lang = data['xml:lang'] if data['xml:lang']

      @timestamp = Time.parse(data['timestamp']) if data['timestamp']
      @header = CXML::Header.new(data['header']) if data['header']
      @header = CXML::Header.new(data['Header']) if data['Header']
      @request = CXML::Request.new(data['request']) if data['request']
      @request = CXML::Request.new(data['Request']) if data['Request']
      @response = CXML::Response.new(data['response']) if data['response']
      @response = CXML::Response.new(data['Response']) if data['Response']
      if data['Message'] && data['Message']['PunchOutOrderMessage']
        @punch_out_order_message = CXML::PunchOutOrderMessage.new(
          data['Message']['PunchOutOrderMessage']
        )
      elsif data['punch_out_order_message']
        @punch_out_order_message = CXML::PunchOutOrderMessage.new(
          data['punch_out_order_message']
        )
      end
    end

    # def setup
    #   @version    = CXML::Protocol.version
    #   @timestamp  = Time.now.utc
    #   @payload_id = "#{@timestamp.to_i}.process.#{Process.pid}@domain.com"
    # end

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

    # Check if document is a punch out order message
    # @return [Boolean]
    def punch_out_order_message?
      !punch_out_order_message.nil?
    end

    def build_attributes
      attrs = {
        'version' => version,
        'payloadID' => payload_id,
        'timestamp' => Time.now.utc.iso8601
      }
      attrs.merge!('xml:lang' => xml_lang)
      attrs
    end

    def render
      node = CXML.builder
      node.cXML(build_attributes) do |doc|
        doc.Header { |n| header&.render(n) }
        request&.render(node)
        response&.render(node)
        punch_out_order_message&.render(node)
      end
      node
    end
  end
end
