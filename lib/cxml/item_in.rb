#     <ItemIn quantity="1">
#       <ItemID>
#         <SupplierPartID>ACC8000160K</SupplierPartID>
#         <SupplierPartAuxiliaryID></SupplierPartAuxiliaryID>
#       </ItemID>
#       <ItemDetail>
#         <Description xml:lang="en">AGENDA MAGAZINE RACK A4 CHARCOAL 25990</Description>
#         <UnitOfMeasure>EA</UnitOfMeasure>
#         <UnitPrice> <Money currency="GBP">5.35</Money> </UnitPrice>
#       </ItemDetail>
#     </ItemIn>
module CXML
  class ItemIn
    attr_accessor :item_id
    attr_accessor :item_detail
    attr_accessor :quantity

    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @item_id = CXML::ItemId.new(data['ItemID']) if data['ItemID']
        @item_detail = CXML::ItemDetail.new(data['ItemDetail']) if data['ItemDetail']
        @quantity = data['quantity']
      end
    end

    def item_id?
      !item_id.nil?
    end

    def item_detail?
      !item_detail.nil?
    end

    def render(node)
      if item_id? && item_detail?
        node.ItemIn('quantity' => quantity) do |item_in|
          item_id.render(node)
          item_detail.render(node)
        end
      end
    end

  end
end
