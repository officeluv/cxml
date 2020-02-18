# Clients send requests for operations. Only one Request element is allowed for each
# cXML envelope element, which simplifies the server implementations, because no
# demultiplexing needs to occur when reading cXML documents. The Request element
# can contain virtually any type of XML data.

module CXML
  class Request
    attr_accessor :id
    attr_accessor :deployment_mode
    attr_accessor :punch_out_setup_request
    attr_accessor :order_request

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @id = data['id']
      @deployment_mode = data['deploymentMode']
      @punch_out_setup_request = CXML::PunchOutSetupRequest.new(data['PunchOutSetupRequest'])
      @order_request = CXML::OrderRequest.new(data['OrderRequest'])
    end

    def render(node)
      node.Request do |n|
        order_request&.render(n)
      end
    end
  end
end
