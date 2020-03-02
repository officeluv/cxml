# frozen_string_literal: true

module CXML
  # contact object within punchout setup request
  class Contact
    attr_accessor :name
    attr_accessor :email

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @name = data['Name'] || data['name']
      @email = data['Email'] || data['email']
    end

    def render(node)
      node.Contact do |n|
        n.Name(name)
        n.Email(email)
      end
    end
  end
end
