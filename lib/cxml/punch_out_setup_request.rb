module CXML
  class PunchOutSetupRequest
    attr_accessor :browser_form_post_url
    attr_accessor :supplier_setup_url

    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @browser_form_post_url = data['BrowserFormPost']['URL']
        @supplier_setup_url = data['SupplierSetup']['URL']
      end
    end
    def render(node)

    end

    def response_return_url
      browser_form_post_url.blank? ? '' : browser_form_post_url.squish
    end

    # def request_return_url
    #   supplier_setup_url.blank? ? '' : supplier_setup_url.squish
    # end
  end
end
