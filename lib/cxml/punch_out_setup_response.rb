# frozen_string_literal: true

module CXML
  class PunchOutSetupResponse
    attr_accessor :start_page
    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @start_page = data['start_page']
      @start_page = data['StartPage']['URL'] if data['StartPage']
    end

    def render(node)
      node.StartPage { |n| n.URL(start_page) }
    end
  end
end
