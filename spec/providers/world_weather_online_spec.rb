require 'spec_helper'

# try to load api key
# if you don't have api go home, no tests today
fn = File.open(File.join(Dir.pwd, 'spec', 'fixtures', "world_weather_api.rb"))
if File.exist?(fn)
  require fn
  WeatherFetcher::Provider::WorldWeatherOnline.api = WORLD_WEATHER_API
end

describe WeatherFetcher::Provider::WorldWeatherOnline do
  before :each do
    @defs = cities_defs
  end

  it "simple fetch" do
    f = WeatherFetcher::Provider::WorldWeatherOnline.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers

    puts weathers.to_yaml
  end
end
