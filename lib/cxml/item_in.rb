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
        @item_id = data['item_id']
        @item_detail = data['item_detail']
      end
    end

    def render(node)
      node.ItemIn('quantity' => quantity) do |item_in|
        item_id.render(node)
        item_detail.render(node)
      end
    end

  end
end
