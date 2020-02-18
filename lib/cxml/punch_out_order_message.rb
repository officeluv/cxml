#   <PunchOutOrderMessage>
#     <BuyerCookie>
#     </BuyerCookie>
#     <PunchOutOrderMessageHeader operationAllowed="create">
#       <Total> <Money currency="GBP">5.35</Money> </Total>
#     </PunchOutOrderMessageHeader>
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
#   </PunchOutOrderMessage>
module CXML
  class PunchOutOrderMessage
    attr_accessor :buyer_cookie
    attr_accessor :punch_out_order_message_header
    attr_accessor :items_in

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @buyer_cookie = data['BuyerCookie'] if data['BuyerCookie']
      @punch_out_order_message_header = CXML::PunchOutOrderMessageHeader.new(data['PunchOutOrderMessageHeader']) if data['PunchOutOrderMessageHeader']
      @items_in = []
    end

    def add_item(item_in_data)
      items_in << CXML::ItemIn.new(item_in_data)
    end

    def punch_out_order_message_header?
      !punch_out_order_message_header.nil?
    end

    def render(node)
      node.Message do
        node.PunchOutOrderMessage do
          node.BuyerCookie{@buyer_cookie} if buyer_cookie
          punch_out_order_message_header.render(node) if punch_out_order_message_header?
          items_in.each{ |item_in| item_in.render(node) }
        end
      end
    end

  end
end
