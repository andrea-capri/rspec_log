require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:example_tests) do |t|
  t.pattern = 'spec/example_tests'
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/unit'
end

task spec:          :rubocop
task example_tests: :rubocop

desc 'Run Rubocop on the compatible files'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = FileList[
    'spec/**/*.rb',
    'smoke_test/**/*.rb',
    'Rakefile',
    'Gemfile',
  ].exclude(
    'spec/fixtures/**/*'
  )
  task.formatters = ['simple']
  task.options = ['-d']
  task.fail_on_error = true
end
