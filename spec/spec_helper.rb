require_relative '../lib/rspec_log'

logs = RSpecLog.new(newfile: true)

RSpec.configure do |config|
  config.color = true
  config.formatter = 'RainbowDocumentation'

  config.after :all do
    logs.write_file
  end
end
