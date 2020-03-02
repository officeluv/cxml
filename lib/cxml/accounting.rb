# frozen_string_literal: true

module CXML
  # accounting details in item outs
  class Accounting
    attr_accessor :segments

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @segments = (data['Segment'] || data['segments'] || []).map do |segment|
        CXML::Segment.new(segment)
      end
    end

    def render(node)
      node.Accounting do |n|
        segments.each { |segment| segment.render(n) }
      end
    end
  end
end
