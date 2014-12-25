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
    expect(weathers).to eq(f.weathers)
    expect(weathers).not_to match_array([])
    expect(weathers.first.fetch_time).to be_within(10).of(Time.now)
    expect(weathers.first.next_fetch_time).to be_within(10).of(Time.now + @klass.weather_updated_every)

    weathers.each do |w|
      expect(w.provider).to eq(WeatherFetcher::Provider::WorldWeatherOnline.provider_name)
    end

    expect(@klass.weather_updated_every).to be > 11 * 3600
    expect(@klass.weather_updated_every).to be <= 24 * 3600

    # puts weathers.to_yaml
  end

  # TODO add some tests
end
