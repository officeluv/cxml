# frozen_string_literal: true

module CXML
  # body of purchase order request
  class OrderRequest < DocumentNode
    accessible_nodes %i[
      order_request_header
      items_out
    ]

    def initialize_item_out(value)
      @items_out = value.map do |item|
        CXML::ItemOut.new(item)
      end
    end

    def initialize_items_out(value)
      @items_out = value.map do |item|
        CXML::ItemOut.new(item)
      end
    end

    def add_item(item_in_data)
      items_out << CXML::ItemOut.new(item_in_data)
    end

    def items_out
      @items_out ||= []
    end
  end
end
