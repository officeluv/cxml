# frozen_string_literal: true

module CXML
  # punchout order message header
  class PunchOutOrderMessageHeader
    attr_accessor :money

    def initialize(data={})
      return unless data.is_a?(Hash) && !data.empty?

      @money = CXML::Money.new(data['Total']['Money']) if data['Total']['Money']
    end

    def money?
      !money.nil?
    end

    def render(node)
      node.PunchOutOrderMessageHeader('operationAllowed' => :create) do |n|
        n.Total { money.render(node) if money? }
      end
    end
  end
end
