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
      @deployment_mode = data['deploymentMode'] || data['deployment_mode']
      punch_out_setup_request = data['PunchOutSetupRequest'] || data['punch_out_setup_request']
      @punch_out_setup_request = CXML::PunchOutSetupRequest.new(punch_out_setup_request) if punch_out_setup_request
      order_request = data['OrderRequest'] || data['order_request']
      @order_request = CXML::OrderRequest.new(order_request) if order_request
    end

    def render(node)
      node.Request do |n|
        order_request&.render(n)
        punch_out_setup_request&.render(n)
      end
    end
  end
end
