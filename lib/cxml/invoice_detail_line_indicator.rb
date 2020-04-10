# frozen_string_literal: true

module CXML
  class InvoiceDetailLineIndicator < DocumentNode
    accessible_attributes %i[
      is_tax_in_line
      is_special_handling_in_line
      is_shipping_in_line
      is_discount_in_line
      is_accounting_in_line
      is_price_adjustment_in_line
    ]
  end
end
