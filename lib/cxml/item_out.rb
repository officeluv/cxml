# frozen_string_literal: true

module CXML
  # items in purchase order message
  class ItemOut
    attr_accessor :item_id
    attr_accessor :item_detail
    attr_accessor :quantity
    attr_accessor :distribution
    attr_accessor :comments

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @item_id = CXML::ItemId.new(data['ItemID']) if data['ItemID']
      @item_detail = CXML::ItemDetail.new(data['ItemDetail']) if data['ItemDetail']
      @quantity = data['quantity']
      @distribution = CXML::Distribution.new(data['Distribution'])
      @comments = data['Comments']
    end

    def item_id?
      !item_id.nil?
    end

    def item_detail?
      !item_detail.nil?
    end

    def render(node)
      return unless item_id? && item_detail?

      node.ItemOut('quantity' => quantity) do
        item_id.render(node)
        item_detail.render(node)
        distribution.render(node)
        node.Comments(@comments)
      end
    end
  end
end
