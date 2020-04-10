# frozen_string_literal: true

module CXML
  class ConfirmationRequest < DocumentNode
    accessible_nodes %i[
      confirmation_header
      order_reference
      confirmation_items
    ]

    def initialize_confirmation_item(value)
      value = [value] unless value.is_a?(Array)
      @confirmation_items = value.map do |item|
        CXML::ConfirmationItem.new(item)
      end
    end

    def initialize_confirmation_items(value)
      value = [value] unless value.is_a?(Array)
      @confirmation_items = value.map do |item|
        CXML::ConfirmationItem.new(item)
      end
    end
  end
end
