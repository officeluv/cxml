# frozen_string_literal: true

require(File.expand_path('lib/cxml/version', __dir__))

Gem::Specification.new do |s|
  s.name        = 'cxml'
  s.version     = CXML::VERSION
  s.summary     = 'Ruby library to work with cXML protocol'
  s.description = 'Ruby library to work with cXML protocol'
  s.homepage    = 'https://github.com/officeluv/cxml'
  s.authors     = ['Josh Beckman', 'Eleni Chappen']
  s.email       = ['josh@officeluv.com', 'eleni@officeluv.com']

  s.add_development_dependency('pry', '~> 0.12.2')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('rubocop')

  s.add_dependency('nokogiri')
  s.add_dependency('xml-simple')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
