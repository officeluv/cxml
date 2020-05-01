# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('..', __dir__)

require 'cxml-ruby'
require 'pry'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
  config.default_formatter = 'doc' if config.files_to_run.one?
end

def fixture_path(filename = nil)
  path = File.expand_path('fixtures', __dir__)
  filename.nil? ? path : File.join(path, filename)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end

def dtd_path_from_url(url)
  return 'spec/fixtures/1.2.037-cXML.dtd' unless url

  match = url.match(%r{/(\d+\.\d+\.\d+)/(\w+\.dtd)}).to_a
  file = 'spec/fixtures/' + match.last(2).join('-')
  return file if File.exist?(file)

  system("curl #{url} -O && mv #{match.last} #{file}")
  file
end

def test_for_xmllint
  return true if system('type xmllint > /dev/null 2>&1')

  puts 'skipping DTD validation without xmllint'
  false
end

def lint_doc_with_dtd(doc)
  file = "spec/output/#{rand}.xml"
  File.open(file, 'w') { |f| f.puts doc.to_xml }
  linted = system("xmllint --noout --dtdvalid #{dtd_path_from_url(doc.dtd_url)} #{file}")
  File.delete(file) if File.exist?(file)
  linted
end
