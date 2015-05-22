#       <ItemDetail>
#         <Description xml:lang="en">AGENDA MAGAZINE RACK A4 CHARCOAL 25990</Description>
#         <UnitOfMeasure>EA</UnitOfMeasure>
#         <UnitPrice> <Money currency="GBP">5.35</Money> </UnitPrice>
#       </ItemDetail>

module CXML
  class ItemDetail
    attr_accessor :description
    attr_accessor :unit_of_measure
    attr_accessor :unit_price
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @description = data['description']
        @unit_of_measure = data['unit_of_measure']
        @unit_price = data['unit_price']
      end
    end

    def render(node)
      node.ItemDetail{
        node.Description{ description }
        node.UnitOfMeasure{ unit_of_measure }
        node.UnitPrice{ unit_price }
      }
    end

  end
end
