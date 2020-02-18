$:.unshift File.expand_path("../..", __FILE__)

require 'cxml'
require 'pry'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

RSpec.configure do |conf|
end

def fixture_path(filename=nil)
  path = File.expand_path("../fixtures", __FILE__)
  filename.nil? ? path : File.join(path, filename)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end
