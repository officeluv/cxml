# frozen_string_literal: true

module CXML
  class StartPage < DocumentNode
    accessible_nodes %i[
      url
    ]

    def render_nodes(node)
      node.URL(url)
    end
  end
end
