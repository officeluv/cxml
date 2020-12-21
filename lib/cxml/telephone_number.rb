# frozen_string_literal: true

module CXML
  class TelephoneNumber < DocumentNode
    accessible_nodes %i[
      country_code
      area_or_city_code
      number
    ]
  end
end
