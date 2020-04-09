# frozen_string_literal: true

module CXML
  # accounting details in item outs
  class Accounting < DocumentNode
    accessible_attributes %i[
      name
    ]
    accessible_nodes %i[
      segments
    ]

    def initialize_segments(value)
      value = [value] unless value.is_a?(Array)
      @segments = value.map do |item|
        CXML::Segment.new(item)
      end
    end

    def initialize_segment(value)
      value = [value] unless value.is_a?(Array)
      @segments = value.map do |item|
        CXML::Segment.new(item)
      end
    end
  end
end
