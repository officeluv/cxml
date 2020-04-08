# frozen_string_literal: true

#       <ItemDetail>
#         <Description xml:lang="en">AGENDA MAGAZINE RACK A4 CHARCOAL 25990</Description>
#         <UnitOfMeasure>EA</UnitOfMeasure>
#         <UnitPrice> <Money currency="GBP">5.35</Money> </UnitPrice>
#       </ItemDetail>

module CXML
  class ItemDetail < DocumentNode
    accessible_nodes %i[
      description
      unit_of_measure
      unit_price
      classification
    ]
  end
end
