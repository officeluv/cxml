# frozen_string_literal: true

module CXML
  class InvoiceDetailItem < DocumentNode
    accessible_attributes %i[
      composite_item_type
      inspection_date
      invoice_line_number
      is_ad_hoc
      item_type
      parent_invoice_line_number
      quantity
      reason
      reference_date
    ]
    accessible_nodes %i[
      comments
      distribution
      extrinsics
      gross_amount
      invoice_detail_discount
      invoice_detail_item_industry
      invoice_detail_item_reference
      invoice_detail_line_shipping
      invoice_detail_line_special_handling
      invoice_item_modifications
      net_amount
      packaging
      price_basis_quantity
      ship_notice_id_info
      ship_notice_line_item_reference
      subtotal_amount
      tax
      total_allowances
      total_amount_without_tax
      total_charges
      unit_of_measure
      unit_price
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
