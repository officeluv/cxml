      # <PunchOutOrderMessageHeader operationAllowed="create">
      # <Total> <Money currency="GBP">5.35</Money> </Total>
      # </PunchOutOrderMessageHeader>
module CXML
  class PunchOutOrderMessageHeader
    attr_accessor :money

    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @money = CXML::Money.new(data['Money']) if data['Money']
      end
    end

    def money?
      !money.nil?
    end

    def render(node)
      node.PunchOutOrderMessageHeader('operationAllowed' => :create) do |n|
        n.Total{ |t| money.render(node) if money? }
      end
    end

  end
end
