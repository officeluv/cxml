# frozen_string_literal: true

module CXML
  class Period < DocumentNode
    accessible_attributes %i[
      start_date
      end_date
    ]
  end
end
