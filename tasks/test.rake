require 'rspec/core/rake_task'

desc "Runs unit tests"
RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = "spec"
end
