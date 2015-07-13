guard 'rspec', verson: 3, all_after_pass: false, cmd: 'rspec --color --format documentation' do
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}.rb" }
end
