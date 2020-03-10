# frozen_string_literal: true

module CXML
  # class for extrinsic data in punchout setup request
  class Extrinsic
    attr_accessor :name
    attr_accessor :content

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @name = data['name']
      @content = data['content']
    end

    def render(node)
      node.Extrinsic(name: name) do |n|
        n.content(content)
      end
    end
  end
end
