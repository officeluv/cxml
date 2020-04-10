# frozen_string_literal: true

require('nokogiri')
require('xmlsimple')

module CXML
  class Parser
    def parse(data)
      hash = XmlSimple.xml_in(data, { 'ForceArray' => false })
      hash.transform_keys!(&method(:underscore_key))
      hash.transform_values!(&method(:underscore_hash_values))
      hash
    end

    private

    def underscore_hash_values(value)
      return value.map(&method(:underscore_hash_values)) if value.is_a?(Array)
      return value unless value.is_a?(Hash)

      value.transform_keys!(&method(:underscore_key))
      value.transform_values!(&method(:underscore_hash_values))
      value
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
