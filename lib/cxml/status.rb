# frozen_string_literal: true

module CXML
  class Status
    attr_accessor :code
    attr_accessor :text
    attr_accessor :xml_lang

    # Initialize a new Status instance
    # @params data [Hash] optional hash with attributes
    def initialize(data = {})
      data = CXML.parse(data) if data.is_a?(String)

      return unless data.is_a?(Hash) && !data.empty?

      @code     = data['code'].to_i
      @text     = data['text']
      @xml_lang = data['xml:lang']
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

    def render(node)
      node.Status(code: @code, text: @text)
    end
  end
end
