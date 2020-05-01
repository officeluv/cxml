# frozen_string_literal: true

module CXML
  class ItemDetail < DocumentNode
    accessible_nodes %i[
      unit_price
      description
      unit_of_measure
      classification
      manufacturer_part_id
      manufacturer_name
      url
      lead_time
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
