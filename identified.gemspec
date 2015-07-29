Gem::Specification.new do |spec|
  spec.name = 'identified'
  spec.version = '0.1.0'
  spec.summary = 'A simple ssn validator.'
  spec.description = 'Validate government document identifiers (like SSNs) with ease.'
  spec.authors = ['Daniel Gollahon']
  spec.email = 'Daniel.Gollahon@gmail.com'
  spec.homepage = 'http://rubygems.org/gems/identified'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(lib|data)/}) }

  spec.required_ruby_version  = '>= 1.9.3'
end
