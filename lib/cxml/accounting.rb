# frozen_string_literal: true

module CXML
  # accounting details in item outs
  class Accounting < DocumentNode
    accessible_nodes %i[
      segments
    ]

    def initialize_segments(value)
      @segments = value.map do |item|
        CXML::Segment.new(item)
      end
    end

    def initialize_segment(value)
      @segments = value.map do |item|
        CXML::Segment.new(item)
      end
    end
  end
end
