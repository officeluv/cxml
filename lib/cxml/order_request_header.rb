# frozen_string_literal: true

module CXML
  # body header of purchase order request
  class OrderRequestHeader < DocumentNode
    accessible_attributes %i[
      order_id
      order_date
      type
    ]
    accessible_nodes %i[
      total
      ship_to
      bill_to
      comments
      contact
    ]

    def type
      @type || 'new'
    end
  end
end
