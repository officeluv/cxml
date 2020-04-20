# frozen_string_literal: true

module CXML
  class Parser
    attr_accessor :data,
                  :parsed_data

    def initialize(data:)
      @data = data
    end

    def parse
      @parsed_data = node_to_hash document
    end

    def document
      doc = Ox.load(data)
      doc.nodes.detect do |node|
        node.value&.match?(/^cxml$/i)
      end || doc
    end

    private

    def node_to_hash(node) # rubocop:disable Metrics/AbcSize
      return node if node.is_a? String
      return node.nodes.first if node.nodes.all?(String) && node.attributes.empty?

      hash = node.attributes
      hash.transform_keys!(&method(:underscore_key))
      node.nodes.reduce(hash) do |acc, child_node|
        next acc if child_node.is_a?(Ox::Comment)

        node_hash = {}
        name = child_node.is_a?(String) ? :content : child_node.value
        node_hash[underscore_key(name)] = node_to_hash(child_node)
        acc.merge(node_hash) do |_key, val1, val2|
          [val1, val2].flatten
        end
      end
    end

    def underscore_key(key)
      return key.to_s.to_sym unless /[A-Z-]|:/.match?(key)

      word = key.to_s.gsub(':', '_')
      word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      word.tr!('-', '_')
      word.downcase!
      word.to_sym
    end
  end
end
