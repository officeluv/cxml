# frozen_string_literal: true

module CXML
  class Error < StandardError; end
  class ParseError < Error; end
  class UnknownAttributeError < ParseError; end
end
