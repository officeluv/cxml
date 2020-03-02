# frozen_string_literal: true

module CXML
  class PunchOutSetupRequest
    attr_accessor :browser_form_post_url
    attr_accessor :supplier_setup_url
    attr_accessor :buyer_cookie
    attr_accessor :extrinsics
    attr_accessor :contact

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      browser_form_post = data['BrowserFormPost'] || {}
      @browser_form_post_url = browser_form_post['URL'] || data['browser_form_post_url']
      supplier_setup = data['SupplierSetup'] || {}
      @supplier_setup_url = supplier_setup['URL'] || data['supplier_setup_url']
      @buyer_cookie = data['BuyerCookie'] || {} || data['buyer_cookie']
      @extrinsics = (data['Extrinsic'] || data['extrinsics'] || [])
                    .map { |e| CXML::Extrinsic.new(e) }
      @contact = CXML::Contact.new(data['Contact'] || data['contact'])
    end

    def response_return_url
      browser_form_post_url.empty? ? '' : browser_form_post_url.squish
    end
  end
end
