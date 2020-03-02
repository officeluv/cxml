# frozen_string_literal: true

#       <ItemID>
#         <SupplierPartID>ACC8000160K</SupplierPartID>
#         <SupplierPartAuxiliaryID></SupplierPartAuxiliaryID>
#       </ItemID>

module CXML
  class ItemId
    attr_accessor :supplier_part_id
    attr_accessor :supplier_part_auxiliary_id

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @supplier_part_id = data['SupplierPartID'] || data['supplier_part_id']
      @supplier_part_auxiliary_id = data['SupplierPartAuxiliaryID'] || data['supplier_part_auxiliary_id']
    end

    def render(node)
      node.ItemID do |_item_in|
        node.SupplierPartID(supplier_part_id)
        node.SupplierPartAuxiliaryID(supplier_part_auxiliary_id)
      end
    end
  end
end
