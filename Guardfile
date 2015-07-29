require 'guard'

ignore /tmp/, /doc/

guard :bundler do
  watch('Gemfile')
  watch('*.gemspec')
end

group :documentation do
  # Critique documentation
  guard :inch do
    watch(/.+\.rb/)
  end

  # Build documentation
  guard 'yard' do
    watch(%r{app/.+\.rb})
    watch(%r{lib/.+\.rb})
    watch(%r{ext/.+\.c})
  end
end

group :critique do
  # Critique code smells
  guard :reek, cli: %w(-c config/reek.yml), run_all_with: ['lib'] do
    watch(%r{.+\.rb$})
  end

  # Critique the most painful code
  guard :flog do
    watch(%r{^lib/(.+)\.rb$})

    # Rails example
    watch(%r{^app/(.+)\.rb$})
  end

  # Critique code for structural similarities
  guard :flay do
    watch(%r{^lib/(.+)\.rb$})

    # Rails example
    watch(%r{^app/(.+)\.rb$})
    watch(%r{^app/(.*)(\.erb|\.haml)$})
    watch('config/routes.rb')

    # Flay specs
    watch(%r{^spec/(.+)_spec\.rb$})
  end

  # Critique code style
  guard :rubocop do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end

# RSpec is often the longest running guard so we put it last
guard :rspec, cmd: 'bundle exec rspec' do
  # watch(%r(.*$)) { 'spec' }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end
