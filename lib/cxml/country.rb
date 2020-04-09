# frozen_string_literal: true

module CXML
  class Country < DocumentNode
    accessible_attributes %i[
      iso_country_code
    ]
  end
end
