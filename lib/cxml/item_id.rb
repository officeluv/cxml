#       <ItemID>
#         <SupplierPartID>ACC8000160K</SupplierPartID>
#         <SupplierPartAuxiliaryID></SupplierPartAuxiliaryID>
#       </ItemID>

module CXML
  class ItemId
    attr_accessor :supplier_part_id
    attr_accessor :supplier_part_auxillary_id
    attr_accessor :quantity
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @quantity = data['quantity']
        @supplier_part_id = data['supplier_part_id']
        @supplier_part_auxillary_id = data['supplier_part_auxillary_id']
      end
    end

    def render(node)
      node.ItemIn('quantity' => quantity) do |item_in|
        node.SupplierPartID{ supplier_part_id }
        node.SupplierPartAuxiliaryID{ supplier_part_auxillary_id }
      end
    end

  end

end
