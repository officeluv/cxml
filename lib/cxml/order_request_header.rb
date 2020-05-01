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
      total
      ship_to
      bill_to
      shipping
      tax
      payment
      payment_term
      contact
      comments
      followup
      document_reference
      supplier_order_info
      extrinsics
      control_keys
      delivery_period
      followup
      id_reference
      legal_identity
      order_request_header_industry
      organizational_unit
      terms_of_delivery
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
