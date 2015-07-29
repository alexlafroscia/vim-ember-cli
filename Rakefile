require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
  t.pattern = Dir.glob('tests/spec/**/*_spec.rb')
end

task :default => :spec

