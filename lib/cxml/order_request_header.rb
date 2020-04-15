# frozen_string_literal: true

module CXML
  # body header of purchase order request
  class OrderRequestHeader < DocumentNode
    accessible_attributes %i[
      agreement_id
      agreement_payload_id
      effective_date
      expiration_date
      is_internal_version
      order_date
      order_id
      order_type
      order_version
      parent_agreement_id
      parent_agreement_payload_id
      pick_up_date
      release_required
      requested_delivery_date
      requisition_id
      ship_complete
      type
    ]
    accessible_nodes %i[
      bill_to
      comments
      contact
      control_keys
      delivery_period
      document_reference
      extrinsics
      followup
      id_reference
      legal_identity
      order_request_header_industry
      organizational_unit
      payment
      payment_term
      ship_to
      shipping
      supplier_order_info
      tax
      terms_of_delivery
      total
    ]

    def type
      @type || 'new'
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
