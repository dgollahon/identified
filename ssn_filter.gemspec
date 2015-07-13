Gem::Specification.new do |spec|
  spec.name = 'ssn_filter'
  spec.version = '0.0.0'
  spec.date = '2015-07-09'
  spec.summary = 'A simple ssn validator.'
  spec.description = 'This gem uses known valid & invalid patterns to verify an ssn is potentially valid for a given date of birth.'
  spec.authors = ['Daniel Gollahon']
  spec.email = 'Daniel.Gollahon@gmail.com'

  spec.files = [
    'lib/ssn_filter.rb',
    'lib/ssn_filter/ssn.rb',
    'lib/ssn_filter/basic_validator.rb',
    'lib/ssn_filter/non_randomized_basic_validator.rb'
  ]

  spec.homepage = 'http://rubygems.org/gems/ssn_filter'
  spec.license = 'MIT'

  spec.add_development_dependency 'rspec', '~> 3.2.1'
end
