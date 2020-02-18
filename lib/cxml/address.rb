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

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @name = data['Name']
      @deliver_to = data['PostalAddress']['DeliverTo']
      @street = data['PostalAddress']['Street']
      @city = data['PostalAddress']['City']
      @state = data['PostalAddress']['State']
      @postal_code = data['PostalAddress']['PostalCode']
      @country = data['PostalAddress']['Country']
    end

    def render(node)
      node.Address do |n|
        n.Name(name)
        n.PostalAddress do |pa|
          pa.DeliverTo(deliver_to)
          pa.Street(street)
          pa.City(city)
          pa.State(state)
          pa.PostalCode(postal_code)
          pa.Country(country)
        end
      end
    end
  end
end
