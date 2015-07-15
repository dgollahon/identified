Gem::Specification.new do |spec|
  spec.name = 'identified'
  spec.version = '0.0.0'
  spec.date = '2015-07-09'
  spec.summary = 'A simple ssn validator.'
  spec.description = 'This gem uses known valid & invalid patterns to verify an ssn is potentially valid for a given date of birth.'
  spec.authors = ['Daniel Gollahon']
  spec.email = 'Daniel.Gollahon@gmail.com'

  spec.files = [
    'lib/identified.rb',
    'lib/identified/area_number.rb',
    'lib/identified/date_value_pair.rb',
    'lib/identified/group_number.rb',
    'lib/identified/high_group_data.rb',
    'lib/identified/high_group_entry.rb',
    'lib/identified/high_group_list.rb',
    'lib/identified/high_group_validator.rb',
    'lib/identified/post_randomization_validator.rb',
    'lib/identified/pre_randomization_validator.rb',
    'lib/identified/serial_number.rb',
    'lib/identified/ssn.rb',
    'lib/identified/errors/error.rb',
    'lib/identified/errors/invalid_date_format_error.rb',
    'lib/identified/errors/malformed_ssn_error.rb',
  ]

  spec.homepage = 'http://rubygems.org/gems/identified'
  spec.license = 'MIT'

  spec.add_development_dependency 'rspec', '~> 3.2'
end
