# rspec_log
RSPEC logging which is persistent accross runs, can be reset on command!

```ruby
gem 'rspec_log'
```

Setup the test this way in your spec_helper.rb file:
```ruby
require 'rspec_log'

config.before :suite do
  logs = RSpecLog.new(newfile: true) # newfile clears the file if it exists
end

config.after :all do
  logs.write_file
end

at_exit { RSpecLog.print_logs_from_file }
```
```ruby
RSpecLog.add_to_log('Name log', 'context info')
```
