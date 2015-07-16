require 'rake'
require 'rspec/core/rake_task'

begin
  require 'devtools'
  Devtools.init_rake_tasks
rescue LoadError => err
  warn err
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color']
end

task default: :spec
