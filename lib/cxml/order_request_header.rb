# frozen_string_literal: true

module CXML
  # body header of purchase order request
  class OrderRequestHeader
    attr_accessor :total
    attr_accessor :ship_to
    attr_accessor :bill_to
    attr_accessor :contact
    attr_accessor :comments
    attr_accessor :order_id
    attr_accessor :order_date
    attr_accessor :type

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @total = CXML::Money.new(data['Total']['Money'])
      @ship_to = CXML::Address.new(data['ShipTo']['Address'])
      @bill_to = CXML::Address.new(data['BillTo']['Address'])
      @contact = CXML::Contact.new(data['Contact'])
      @order_id = data['orderID']
      @order_date = data['orderDate']
      @type = data['type'] || 'new'
      @comments = data['Comments']
    end

    def render(node)
      node.OrderRequestHeader(node_attributes) do |n|
        n.ShipTo { ship_to.render(n) }
        n.BillTo { bill_to.render(n) }
        contact.render(node)
        n.Comments(comments)
      end
    end

    private

    def node_attributes
      {
        'orderID' => order_id,
        'orderDate' => order_date,
        'type' => type
      }
    end
  end
end
