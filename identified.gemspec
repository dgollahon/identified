Gem::Specification.new do |spec|
  spec.name = 'identified'
  spec.version = '0.1.0'
  spec.summary = 'A simple ssn validator.'
  spec.description = 'Validate government document identifiers (like SSNs) with ease.'
  spec.authors = ['Daniel Gollahon']
  spec.email = 'Daniel.Gollahon@gmail.com'
  spec.homepage = 'http://rubygems.org/gems/identified'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'pry'

  spec.required_ruby_version  = '>= 2.0.0'
end
