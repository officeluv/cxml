#       <ItemID>
#         <SupplierPartID>ACC8000160K</SupplierPartID>
#         <SupplierPartAuxiliaryID></SupplierPartAuxiliaryID>
#       </ItemID>

module CXML
  class ItemId

    attr_accessor :supplier_part_id
    attr_accessor :supplier_part_auxillary_id

    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @supplier_part_id = data['SupplierPartID']
        @supplier_part_auxillary_id = data['SupplierPartAuxilaryID']
      end
    end

    def render(node)
      node.ItemID do |item_in|
        node.SupplierPartID(supplier_part_id)
        node.SupplierPartAuxiliaryID(supplier_part_auxillary_id)
      end
    end

  end

end
