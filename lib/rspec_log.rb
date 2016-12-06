require 'colorize'
require 'yaml'

DEFAULT_LOG_FILE = '.rspec_log.yml'.freeze

# Class that allows for displaying logs or general messages at that are consistent across rspec tests
class RSpecLog
  def initialize(filename: DEFAULT_LOG_FILE, newfile: false)
    raise 'RSpec must be defined to create RSpec log' if (defined? RSpec).nil?

    @filename = filename
    RSpecLog.write_hash_to_file({}, @filename) if newfile || RSpecLog.load_yaml_log(filename).nil?
    RSpecLog.log_hash_set(YAML.load_file(@filename))

    at_exit { RSpecLog.print_logs_from_file(filename: @filename) }
  end

  # Writes log_hash to, by default, currently set log file or custom file passed to it
  def write_file(filename: @filename)
    raise 'Filename is not set, you need to initialize RSpecLog before writing' if filename.nil?
    RSpecLog.write_hash_to_file(RSpecLog.log_hash, filename)
  end

  # Parse the YAML log file and print it out in a nice manner
  def self.print_logs_from_file(filename: DEFAULT_LOG_FILE)
    file_contents = RSpecLog.load_yaml_log(filename)

    return if file_contents.nil? || file_contents.empty?
    puts 'RSpecLogs:'.blue.underline

    file_contents.each do |key, value|
      puts key
      value.each { |v| puts "  - #{v.to_s.yellow}" }
    end
  end

  # @name - Name of the log message
  # @value - Content of log message
  def self.add_to_log(name, value)
    log_hash[current_node] = [] if log_hash[current_node].nil?
    log_hash[current_node] << "#{name}, #{value}"
    log_hash_set(log_hash)
  end

  private_class_method

  def self.load_yaml_log(filename)
    YAML.load_file(filename)
  rescue StandardError => e
    puts e.to_s.yellow
    nil
  end

  def self.write_hash_to_file(log_hash, filename = DEFAULT_LOG_FILE)
    File.open(filename, 'w') { |f| f.write(YAML.dump(log_hash, line_width: -1)) }
  end

  def self.log_hash
    RSpec.instance_variable_get(:@log_hash)
  end

  def self.log_hash_set(item)
    RSpec.instance_variable_set(:@log_hash, item)
  end

  def self.current_node
    ENV.fetch('TARGET_HOST', "#{RSpec.current_example.description}:".blue.bold)
  end
end
