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

    def render(node = CXML.builder)
      node.send(self.class.name.split('::').last, node_attributes) do |n|
        n.text(content) if content
        render_nodes(n)
      end
      node
    end

    def render_nodes(node)
      self.class.nodes.each do |child_node_name|
        child_value = send(child_node_name)
        if child_value.is_a?(Array)
          child_value.each do |child_value_n|
            render_child_node(node, child_node_name, child_value_n)
          end
        else
          render_child_node(node, child_node_name, child_value)
        end
      end
    end

    private

    def render_child_node(node, name, value)
      return if value.respond_to?(:empty?) ? value.empty? : !value

      if value.is_a?(DocumentNode)
        value.render(node)
      else
        node.send(camelize(name), value)
      end
    end

    def node_attributes
      self.class.attributes.each_with_object({}) do |attr, obj|
        value = send(attr)
        value = value.iso8601 if value.is_a?(Time)
        next if value.respond_to?(:empty?) ? value.empty? : !value

        string_attr = if attr.to_sym == :xml_lang
                        'xml:lang'
                      else
                        camelize(attr, false)
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

      send("#{key}=", val)
    end

    def camelize(string, uppercase_first_letter = true)
      string = if uppercase_first_letter
                 string.to_s.sub(/^[a-z\d]*/, &:capitalize)
               else
                 string.to_s.sub(/^(?:(?=\b|[A-Z_])|\w)/, &:downcase)
               end
      string.gsub(/_id(_)?$/, '_ID\1').gsub(%r{(?:_|(/))([a-z\d]*)}) do
        "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}"
      end.gsub('/', '::')
    end
  end
end
