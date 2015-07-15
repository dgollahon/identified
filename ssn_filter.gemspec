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
    'lib/ssn_filter/area_number.rb',
    'lib/ssn_filter/date_value_pair.rb',
    'lib/ssn_filter/group_number.rb',
    'lib/ssn_filter/high_group_data.rb',
    'lib/ssn_filter/high_group_entry.rb',
    'lib/ssn_filter/high_group_list.rb',
    'lib/ssn_filter/high_group_validator.rb',
    'lib/ssn_filter/post_randomization_validator.rb',
    'lib/ssn_filter/pre_randomization_validator.rb',
    'lib/ssn_filter/serial_number.rb',
    'lib/ssn_filter/ssn.rb',
    'lib/ssn_filter/errors/error.rb',
    'lib/ssn_filter/errors/invalid_date_format_error.rb',
    'lib/ssn_filter/errors/malformed_ssn_error.rb',
  ]

  spec.homepage = 'http://rubygems.org/gems/ssn_filter'
  spec.license = 'MIT'

  spec.add_development_dependency 'rspec', '~> 3.2'
end
