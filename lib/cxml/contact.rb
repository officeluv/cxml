# frozen_string_literal: true

module CXML
  # contact object within punchout setup request
  class Contact
    attr_accessor :name
    attr_accessor :email

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @name = data['Name']
      @email = data['Email']
    end
  end
end
