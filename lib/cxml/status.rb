# frozen_string_literal: true

module CXML
  class Status < DocumentNode
    accessible_attributes %i[
      code
      text
      xml_lang
    ]

    def code
      @code&.to_i
    end

    # Check if status is success
    # @return [Boolean]
    def success?
      [200, 201, 204, 280, 281].include?(code)
    end

    # Check if status is failure
    # @return [Boolean]
    def failure?
      !success?
    end
  end
end
