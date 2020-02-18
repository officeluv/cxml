# frozen_string_literal: true

module CXML
  # details for accounting objects
  class Segment
    attr_accessor :id
    attr_accessor :description
    attr_accessor :type

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @id = data['id']
      @description = data['description']
      @type = data['type']
    end

    def render(node)
      node.Segment('id' => id, 'description' => description, type => 'type')
    end
  end
end
