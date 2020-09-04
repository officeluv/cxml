# frozen_string_literal: true

module CXML
  # base class for document nodes
  class DocumentNode
    attr_accessor :content

    def self.accessible_attributes(attrs)
      raise(ArgumentError) unless attrs.is_a?(Array)

      @attributes = attrs
      attr_accessor(*attrs)
    end

    def self.attributes
      @attributes || []
    end

    def self.accessible_nodes(new_nodes)
      raise(ArgumentError) unless new_nodes.is_a?(Array)

      @nodes = new_nodes
      attr_accessor(*new_nodes)
    end

    def self.nodes
      @nodes || []
    end

    def initialize(data = {})
      if data.is_a?(String)
        @content = data
        return
      end
      data = data.serializable_hash if data.is_a?(self.class)
      return unless data.is_a?(Hash)

      data.each(&method(:initialize_attribute))
    end

    def serializable_hash
      (self.class.attributes + self.class.nodes + [:content]).each_with_object({}) do |attr, obj|
        value = send(attr)
        value = value.iso8601 if value.is_a?(Time)
        next if value.respond_to?(:empty?) ? value.empty? : !value

        obj[attr] = value.is_a?(DocumentNode) ? value.serializable_hash : value
      end
    end

    def node_name
      self.class.name.split('::').last
    end

    def to_element
      element = ox_element
      element << content.to_s if content
      self.class.nodes.each do |child_node_name|
        child_value = send(child_node_name)
        if child_value.is_a?(Array)
          child_value.each do |child_value_n|
            render_child_node(element, child_node_name, child_value_n)
          end
        else
          render_child_node(element, child_node_name, child_value)
        end
      end
      element
    end

    private

    def ox_element
      element = Ox::Element.new node_name
      node_attributes.each do |key, val|
        element[key] = val
      end
      element
    end

    def render_child_node(element, name, value)
      return if value.respond_to?(:empty?) ? value.empty? : !value

      if value.is_a?(DocumentNode)
        element << value.to_element
        return element
      end
      value_element = Ox::Element.new(camelize(name))
      if value.is_a? Hash
        value.each do |value_key, value_val|
          next value_element << value_val.to_s if value_key == :content

          value_element[value_key] = value_val
        end
      else
        value_element << value.to_s
      end
      element << value_element
      element
    end

    def node_attributes
      self.class.attributes.each_with_object({}) do |attr, obj|
        value = send(attr)
        value = value.iso8601 if value.is_a?(Time)
        next if value.respond_to?(:empty?) ? value.empty? : !value

        string_attr = if attr.to_sym == :xml_lang
                        'xml:lang'
                      else
                        camelize(attr, uppercase_first_letter: false)
                      end
        obj[string_attr] = value
      end
    end

    def initialize_attribute(key, val)
      return send("initialize_#{key}", val) if respond_to?("initialize_#{key}")
      return send("#{key}=", val) if self.class.attributes.include?(key)

      klass = "CXML::#{camelize(key)}"
      send("#{key}=", Object.const_get(klass).new(val))
    rescue NoMethodError => e
      raise(UnknownAttributeError, e) if CXML.raise_unknown_elements

      CXML.logger.warn(e)
    rescue NameError => e
      raise(e) unless e.to_s.match?(klass)

      initialize_attribute_raw(key, val)
    end

    def initialize_attribute_raw(key, val)
      if val.is_a?(Hash) && val.keys == [:content]
        send("#{key}=", val[:content])
      else
        send("#{key}=", val)
      end
    end

    def camelize(string, uppercase_first_letter: true)
      string = if uppercase_first_letter
                 string.to_s.sub(/^[a-z\d]*/, &:capitalize)
               else
                 string.to_s.sub(/^(?:(?=\b|[A-Z_])|\w)/, &:downcase)
               end
      return 'URL' if string.match?(/^url$/i)

      string.gsub(/_id(_)?$/, '_ID\1').gsub(%r{(?:_|(/))([a-z\d]*)}) do
        "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}"
      end.gsub('/', '::')
    end
  end
end
