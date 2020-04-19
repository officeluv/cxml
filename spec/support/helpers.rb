# frozen_string_literal: true

def build_item_in
  CXML::Parser.new(data: fixture('item_in.xml')).parse
end
