require 'spec_helper'

describe WeatherFetcher::Provider::Wunderground do
  before :each do
    @defs = cities_defs_only_metar
    @klass = WeatherFetcher::Provider::Wunderground
  end

  it "simple fetch" do
    f = @klass.new(@defs)
    weathers = f.fetch
    expect(weathers).to eq(f.weathers)
    expect(weathers).not_to match_array([])
    expect(weathers.first.fetch_time).to be_within(10).of(Time.now)
    expect(weathers.first.next_fetch_time).to be_within(10).of(Time.now + @klass.weather_updated_every)

    # puts weathers.to_yaml
  end
end
