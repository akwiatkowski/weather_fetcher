require 'spec_helper'

describe WeatherFetcher::Provider::Wunderground do
  before :each do
    @defs = cities_defs_only_metar
    @klass = WeatherFetcher::Provider::Wunderground
  end

  it "simple fetch" do
    f = @klass.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers

    weathers.size.should == 1
    weathers.first.fetch_time.should be_within(10).of(Time.now)
    weathers.first.next_fetch_time.should be_within(10).of(Time.now + @klass.weather_updated_every)

    # puts weathers.to_yaml
  end
end
