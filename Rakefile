require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/unit'
end

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
