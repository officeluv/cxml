# frozen_string_literal: true

module CXML
  class Modifications < DocumentNode
    accessible_nodes %i[
      modifications
    ]

    def initialize_modification(value)
      value = [value] unless value.is_a?(Array)
      @modifications = value.map do |item|
        Modification.new(item)
      end
    end

    def initialize_modifications(value)
      value = [value] unless value.is_a?(Array)
      @modifications = value.map do |item|
        Modification.new(item)
      end
    end
  end
end
