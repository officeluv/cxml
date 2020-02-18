# frozen_string_literal: true

module CXML
  # accounting info for ItemOut
  class Distribution
    attr_accessor :accounting
    attr_accessor :charge

    def initialize(data)
      return unless data.is_a?(Hash) && !data.empty?

      @accounting = CXML::Accounting.new(data['Accounting'])
      @charge = CXML::Money.new(data['Charge']['Money'])
    end

    def render(node)
      node.Destribution do
        accounting.render(node)
        node.Charge { charge.render(node) }
      end
    end
  end
end
