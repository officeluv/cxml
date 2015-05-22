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
    attr_accessor :item_ins
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @buyer_cookie = data['buyer_cookie'] if data['buyer_cookie']
        @punch_out_order_message_header = data['punch_out_order_message_header'] if data['punch_out_order_message_header']
        @item_ins = []
      end
    end

    def add_item(item_in_data)
      items_ins << ItemIn.new(item_in_data)
    end

    def render(node)
      node.PunchOutOrderMessage{
        node.BuyerCookie{@buyer_cookie} if buyer_cookie
        node.PunchOutOrderMessageHeader('operationAllowed' => :create) {
          punch_out_order_message_header.render(node) if punch_out_order_message_header
        }
        items_in.each{ |item_in| items_in.render(node) }
      }
    end

  end
end
