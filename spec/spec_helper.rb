$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'weather_fetcher'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  #config.filter_run :html => false
  config.filter_run_excluding :html => true
end

def load_fixture(f)
  return YAML::load(File.open(File.join(Dir.pwd, 'spec', 'fixtures', "#{f}.yml")))
end
