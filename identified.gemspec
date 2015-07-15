Gem::Specification.new do |spec|
  spec.name = 'identified'
  spec.version = '0.0.0'
  spec.date = '2015-07-09'
  spec.summary = 'A simple ssn validator.'
  spec.description = 'This gem uses known valid & invalid patterns to verify an ssn is potentially valid for a given date of birth.'
  spec.authors = ['Daniel Gollahon']
  spec.email = 'Daniel.Gollahon@gmail.com'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.homepage = 'http://rubygems.org/gems/identified'
  spec.license = 'MIT'

  spec.add_development_dependency 'rspec', '~> 3.2'
end
