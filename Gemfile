source 'https://rubygems.org'

gemspec name: 'identified'

gem 'rake', '~> 10.4'

group :metrics do
  # Dev tools
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git'
end

group :development, :test do
  gem 'pry', '~> 0.10'

  gem 'pry-byebug', '~> 1.3.3'
end

group :guard do
  # Filewatcher and runner
  gem 'guard', '~> 2.12.4'

  # Autorun documentation critic
  gem 'guard-inch', '~> 0.1'

  # Autogen docs
  gem 'guard-yard', '~> 2.1'

  # Autorun style critic
  gem 'guard-rubocop', '~> 1.2'

  # Autorun codesmell critic
  gem 'guard-reek', '= 0.0.3', github: 'backus/guard-reek'

  # Autorun similar code critic
  gem 'guard-flay', '= 0.0.3', github: 'backus/guard-flay'

  # Autorun painful code critic
  gem 'guard-flog', '= 0.0.4', github: 'backus/guard-flog'

  # Autorun specs
  gem 'guard-rspec', '~> 4.6'

  # rebundle
  gem 'guard-bundler', '~> 2.1'
end
