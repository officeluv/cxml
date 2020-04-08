# frozen_string_literal: true

#       <ItemID>
#         <SupplierPartID>ACC8000160K</SupplierPartID>
#         <SupplierPartAuxiliaryID></SupplierPartAuxiliaryID>
#       </ItemID>

module CXML
  class ItemId < DocumentNode
    accessible_nodes %i[
      supplier_part_id
      supplier_part_auxiliary_id
    ]
  end
end
