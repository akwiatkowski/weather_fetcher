require 'spec_helper'

describe WeatherFetcher::Provider::AviationWeather do
  before :each do
    @defs = cities_defs_only_metar
    @klass = WeatherFetcher::Provider::AviationWeather
  end

  it "simple fetch" do
    f = @klass.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers

    # so not nice provider
    # sometimes it doesn't work

    if weathers.size > 0
      expect(weathers).to eq(f.weathers)
      expect(weathers.size).to eq(1)
      expect(weathers.first.fetch_time).to be_within(10).of(Time.now)
      expect(weathers.first.next_fetch_time).to be_within(10).of(Time.now + @klass.weather_updated_every)
    end

    # puts weathers.to_yaml
  end
end
