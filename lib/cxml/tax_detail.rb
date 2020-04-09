# frozen_string_literal: true

module CXML
  class TaxDetail < DocumentNode
    accessible_attributes %i[
      purpose
      category
      percentage_rate
      is_vat_recoverable
      tax_point_date
      payment_date
      is_triangular_transaction
      exempt_detail
      is_withholding_tax
      tax_rate_type
      base_percentage_rate
      is_included_in_price
    ]
    accessible_nodes %i[
      taxable_amount
      tax_amount
      tax_location
      tax_adjustment_amount
      description
      tax_regime
      tax_exemption
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
