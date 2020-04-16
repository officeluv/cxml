# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('..', __dir__)

require 'cxml-ruby'
require 'pry'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
end

def fixture_path(filename = nil)
  path = File.expand_path('fixtures', __dir__)
  filename.nil? ? path : File.join(path, filename)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end
