# frozen_string_literal: true

module CXML
  # body header of purchase order request
  class OrderRequestHeader
    attr_accessor :total
    attr_accessor :ship_to
    attr_accessor :bill_to
    attr_accessor :contact
    attr_accessor :comments

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @total = CXML::Money.new(data['Total']['Money'])
      @ship_to = CXML::Address.new(data['ShipTo']['Address'])
      @bill_to = CXML::Address.new(data['BillTo']['Address'])
      @contact = CXML::Contact.new(data['Contact'])
      @comments = data['Comments']
    end

    def render(node)
      node.OrderRequestHeader do |n|
        n.ShipTo { ship_to.render(n) }
        n.BillTo { bill_to.render(n) }
        contact.render(node)
        n.Comments(comments)
      end
    end
  end
end
