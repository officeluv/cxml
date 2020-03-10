# frozen_string_literal: true

module CXML
  # shipping details object within punchout setup request
  class ShipTo
    attr_accessor :address

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @address = CXML::Address.new(data['Address'] || data['address'])
    end

    def render(node)
      node.ShipTo do
        address&.render(node)
      end
    end
  end
end
