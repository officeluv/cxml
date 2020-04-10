# frozen_string_literal: true

module CXML
  class Sender < DocumentNode
    accessible_nodes %i[
      credential
      user_agent
    ]
  end
end
