# frozen_string_literal: true

module CXML
  class PunchOutSetupRequest < DocumentNode
    accessible_nodes %i[
      browser_form_post
      supplier_setup
      buyer_cookie
      ship_to
      extrinsics
      contact
    ]

    def initialize_extrinsic(value)
      @extrinsics = value.map do |item|
        Extrinsic.new(item)
      end
    end

    def initialize_extrinsics(value)
      @extrinsics = value.map do |item|
        Extrinsic.new(item)
      end
    end
  end
end
