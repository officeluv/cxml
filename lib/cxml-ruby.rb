# frozen_string_literal: true

require('time')
require('logger')
require('ox')
require('cxml/document_node')
Dir[File.join(__dir__, 'cxml', '*.rb')].sort.each { |file| require file }

module CXML
  def self.parse(str)
    CXML::Parser.new(data: str).parse
  end

  def self.configure
    yield(self)
  end

  def self.raise_unknown_elements
    @raise_unknown_elements.nil? ? @raise_unknown_elements ||= true : @raise_unknown_elements
  end

  def self.raise_unknown_elements=(setting)
    @raise_unknown_elements = setting
  end

  def self.logger
    return @logger if @logger

    @logger ||= Logger.new(STDOUT, level: :warn)
  end

  def self.logger=(new_logger)
    @logger = new_logger
  end
end
