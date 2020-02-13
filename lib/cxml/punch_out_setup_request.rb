module CXML
  class PunchOutSetupRequest

    attr_accessor :browser_form_post_url
    attr_accessor :supplier_setup_url

    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        browser_form_post = data['BrowserFormPost'] || {}
        @browser_form_post_url = browser_form_post['URL']
        supplier_setup = data['SupplierSetup'] || {}
        @supplier_setup_url = supplier_setup['URL']
      end
    end

    def response_return_url
      browser_form_post_url.empty? ? '' : browser_form_post_url.squish
    end

  end
end
