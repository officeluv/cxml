# frozen_string_literal: true

module CXML
  class InvoiceDetailRequestHeader < DocumentNode
    accessible_attributes %i[
      invoice_id
      is_information_only
      purpose
      operation
      invoice_date
      invoice_origin
    ]
    accessible_nodes %i[
      invoice_detail_header_indicator
      invoice_detail_line_indicator
      invoice_partner
      document_reference
      invoice_id_info
      payment_term
      period
      extrinsics
      comments
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
