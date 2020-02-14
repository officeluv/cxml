module CXML
  class PunchOutSetupRequest
    attr_accessor :browser_form_post_url
    attr_accessor :supplier_setup_url
    attr_accessor :buyer_cookie
    attr_accessor :extrinsics
    attr_accessor :contact

    def initialize(data={})
      if data.is_a?(Hash) && !data.empty?
        browser_form_post = data['BrowserFormPost'] || {}
        @browser_form_post_url = browser_form_post['URL']
        supplier_setup = data['SupplierSetup'] || {}
        @supplier_setup_url = supplier_setup['URL']
        @buyer_cookie = data['BuyerCookie'] || {}
        @extrinsics = (data['Extrinsic'] || [])
                      .map { |e| CXML::Extrinsic.new(e) }
        @contact = CXML::Contact.new(data['Contact'])
      end
    end

    def response_return_url
      browser_form_post_url.empty? ? '' : browser_form_post_url.squish
    end

  end
end
