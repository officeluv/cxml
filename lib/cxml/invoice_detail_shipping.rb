# frozen_string_literal: true

module CXML
  class InvoiceDetailShipping < DocumentNode
    accessible_attributes %i[
      shipping_date
    ]
    accessible_nodes %i[
      contacts
      document_reference
    ]

    def initialize_contact(value)
      value = [value] unless value.is_a?(Array)
      @contacts = value.map do |item|
        Contact.new(item)
      end
    end

    def initialize_contacts(value)
      value = [value] unless value.is_a?(Array)
      @contacts = value.map do |item|
        Contact.new(item)
      end
    end
  end
end
