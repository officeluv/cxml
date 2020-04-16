# frozen_string_literal: true

require(File.expand_path('lib/cxml/version', __dir__))

Gem::Specification.new do |s|
  s.name        = 'cxml-ruby'
  s.version     = CXML::VERSION
  s.license     = 'MIT'
  s.summary     = 'Parse/generate documents with the cXML protocol'
  s.description = 'Ruby library to parse/generate documents with the cXML protocol'
  s.homepage    = 'https://github.com/officeluv/cxml-ruby'
  s.authors     = ['Josh Beckman', 'Eleni Chappen']
  s.email       = ['josh@officeluv.com', 'eleni@officeluv.com']

  s.add_development_dependency('pry', '~> 0.12')
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('rspec', '~> 3.9')
  s.add_development_dependency('rubocop', '~> 0.81')

  s.add_dependency('nokogiri', '~> 1.10')
  s.add_dependency('xml-simple', '~> 1.1')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
