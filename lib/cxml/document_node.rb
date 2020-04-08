# frozen_string_literal: true

module CXML
  # base class for document nodes
  class DocumentNode
    attr_accessor :content

    def self.accessible_attributes(attrs)
      @attributes = attrs
      attr_accessor(*attrs)
    end

    def self.attributes
      @attributes || []
    end

    def self.accessible_nodes(nodes)
      @nodes = nodes
      attr_accessor(*nodes)
    end

    def self.nodes
      @nodes || []
    end

    def initialize(data = {})
      data.each(&method(:initialize_attribute))
    end

    def render(node)
      node.send(self.class.name.split('::').last) do |n|
        n.content(content) if content
        render_nodes(n)
      end
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
      if value.is_a?(DocumentNode)
        value.render(node)
      else
        node.send(camelize(name), value)
      end
    end

    def node_attributes
      self.class.attributes.each_with_object({}) do |attr, obj|
        obj[camelize(attr, false)] = send(attr)
      end
    end

    def initialize_attribute(key, val)
      return send("initialize_#{key}", val) if respond_to?("initialize_#{key}")

      send("#{key}=", Object.const_get("CXML::#{camelize(key)}").new(val))
    rescue NameError
      send("#{key}=", val)
    end

    def camelize(string, uppercase_first_letter = true)
      string = if uppercase_first_letter
                 string.to_s.sub(/^[a-z\d]*/, &:capitalize)
               else
                 string.to_s.sub(/^(?:(?=\b|[A-Z_])|\w)/, &:downcase)
               end
      string.gsub(%r{(?:_|(/))([a-z\d]*)}) do
        "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}"
      end.gsub('/', '::')
    end
  end
end
