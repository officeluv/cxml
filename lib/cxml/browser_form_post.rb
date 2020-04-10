# frozen_string_literal: true

module CXML
  class BrowserFormPost < DocumentNode
    accessible_nodes %i[
      url
    ]

    def render_nodes(node)
      node.URL(url)
    end
  end
end
