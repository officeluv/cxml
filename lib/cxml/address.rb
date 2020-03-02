# frozen_string_literal: true

module CXML
  # address, typically in a purchase order message
  class Address
    attr_accessor :name
    attr_accessor :deliver_to
    attr_accessor :street
    attr_accessor :city
    attr_accessor :state
    attr_accessor :postal_code
    attr_accessor :country
    attr_accessor :email
    attr_accessor :iso_country_code
    attr_accessor :address_id

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @name = data['Name'] || data['name']
      @email = data['Email'] || data['email']
      @iso_country_code = data['isoCountryCode'] || data['iso_country_code']
      @address_id = data['addressID'] || data['address_id']
      @deliver_to = data['deliver_to']
      @street = data['street']
      @city = data['city']
      @state = data['state']
      @postal_code = data['postal_code']
      @country = data['country']
      return unless data['PostalAddress']

      @deliver_to = data['PostalAddress']['DeliverTo']
      @street = data['PostalAddress']['Street']
      @city = data['PostalAddress']['City']
      @state = data['PostalAddress']['State']
      @postal_code = data['PostalAddress']['PostalCode']
      @country = data['PostalAddress']['Country']
    end

    def render(node)
      node.Address(node_attributes) do |n|
        n.Name(name)
        n.PostalAddress do |pa|
          pa.DeliverTo(deliver_to)
          pa.Street(street)
          pa.City(city)
          pa.State(state)
          pa.PostalCode(postal_code)
          pa.Country(country)
        end
        n.Email(email)
      end
    end

    private

    def node_attributes
      {
        'isoCountryCode' => iso_country_code,
        'addressID' => address_id
      }
    end
  end
end
