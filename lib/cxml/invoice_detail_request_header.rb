# frozen_string_literal: true

module CXML
  class InvoiceDetailRequestHeader < DocumentNode
    accessible_attributes %i[
      invoice_date
      invoice_id
      invoice_origin
      is_information_only
      operation
      purpose
    ]
    accessible_nodes %i[
      comments
      document_reference
      extrinsics
      invoice_detail_header_indicator
      invoice_detail_line_indicator
      invoice_detail_shipping
      invoice_id_info
      invoice_partners
      payment_term
      period
    ]

    def initialize_invoice_partner(value)
      value = [value] unless value.is_a?(Array)
      @invoice_partners = value.map do |item|
        InvoicePartner.new(item)
      end
    end

    def initialize_invoice_partners(value)
      value = [value] unless value.is_a?(Array)
      @invoice_partners = value.map do |item|
        InvoicePartner.new(item)
      end
    end

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
