# frozen_string_literal: true

module CXML
  class ItemDetail < DocumentNode
    accessible_nodes %i[
      description
      unit_of_measure
      unit_price
      classification
      extrinsics
    ]

    def initialize_extrinsic(value)
      value = [value] unless value.is_a?(Array)
      @extrinsics = value.map do |item|
        Extrinsic.new(item)
      end
    end

    def initialize_extrinsics(value)
      value = [value] unless value.is_a?(Array)
      @extrinsics = value.map do |item|
        Extrinsic.new(item)
      end
    end
  end
end
