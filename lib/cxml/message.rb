# frozen_string_literal: true

module CXML
  class Message < DocumentNode
    accessible_attributes %i[
      deployment_mode
      id
    ]
    accessible_nodes %i[
      punch_out_order_message
    ]
  end
end
