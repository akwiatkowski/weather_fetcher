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
    @klass = WeatherFetcher::Provider::WorldWeatherOnline
  end

  it "simple fetch" do
    f = @klass.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers
    weathers.size.should > 1
    weathers.first.fetch_time.should be_within(10).of(Time.now)
    weathers.first.next_fetch_time.should be_within(10).of(Time.now + @klass.weather_updated_every)
    weathers.each do |w|
      w.provider.should == WeatherFetcher::Provider::WorldWeatherOnline.provider_name
    end

    @klass.weather_updated_every.should > 11 * 3600
    @klass.weather_updated_every.should <= 24 * 3600

  end

  # TODO add some tests
end
