# frozen_string_literal: true

module CXML
  # body of purchase order request
  class OrderRequest
    attr_accessor :order_request_header
    attr_accessor :items_out

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @order_request_header = CXML::OrderRequestHeader.new(data['OrderRequestHeader'] || data['order_request_header'])
      @items_out = (data['ItemOut'] || data['items_out'] || []).map do |item|
        CXML::ItemOut.new(item)
      end
    end

    def render(node)
      node.OrderRequest do |n|
        order_request_header&.render(n)
        items_out&.each { |item_out| item_out.render(n) }
      end
    end
  end
end
