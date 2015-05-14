module CXML
  class PunchOutSetupResponse
    attr_accessor :start_page
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @start_page = data['StartPage']['URL']
      end
    end

    def render(node)
      node.StartPage{ |n| n.URL(start_page) }
    end

  end
end
