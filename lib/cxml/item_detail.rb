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
        @description = data['Description']
        @unit_of_measure = data['UnitOfMeasure']
        @unit_price = data['UnitPrice']
      end
    end

    def render(node)
      node.ItemDetail do
        node.Description(description)
        node.UnitOfMeasure(unit_of_measure)
        node.UnitPrice(unit_price)
      end
    end

  end
end
