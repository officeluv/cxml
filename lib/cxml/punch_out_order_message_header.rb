      # <PunchOutOrderMessageHeader operationAllowed="create">
      # <Total> <Money currency="GBP">5.35</Money> </Total>
      # </PunchOutOrderMessageHeader>
module CXML
  class PunchOutOrderMessageHeader
    attr_accessor :money

    def initialize(money=nil)
      if data.kind_of?(Hash) && !data.empty?
        @money = money
      end
    end


    def render(node)


      node.PunchOutOrderMessageHeader{ |n|
        n.Total{ |t|
          t.Money(:currency => "GBP") money  }}
    end

  end
end
