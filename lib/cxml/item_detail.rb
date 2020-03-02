# frozen_string_literal: true

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
    attr_accessor :unspsc

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @description = data['Description'] || data['description']
      @unit_of_measure = data['UnitOfMeasure'] || data['unit_of_measure']
      @unspsc = data['ClassificationUnspsc'] || data['unspsc']
      @unit_price = CXML::Money.new(data['unit_price']) if data['unit_price']
      @unit_price = CXML::Money.new(data['UnitPrice']['Money']) if data['UnitPrice']
    end

    def render(node)
      node.ItemDetail do
        node.Description(description)
        node.UnitOfMeasure(unit_of_measure)
        node.UnitPrice { unit_price.render(node) }
        node.Classification(unspsc, 'domain' => 'UNSPSC') unless unspsc.nil? || unspsc.empty?
      end
    end
  end
end
