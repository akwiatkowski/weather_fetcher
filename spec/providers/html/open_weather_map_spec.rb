require 'spec_helper'

describe WeatherFetcher::Provider::OpenWeatherMap do
  before :each do
    @defs = cities_defs
    @klass = WeatherFetcher::Provider::OpenWeatherMap
  end

  it "simple fetch" do
    f = @klass.new(@defs)
    weathers = f.fetch
    expect(weathers).to eq(f.weathers)
    expect(weathers).not_to match_array([])
    expect(weathers.first.fetch_time).to be_within(10).of(Time.now)
    expect(weathers.first.next_fetch_time).to be_within(10).of(Time.now + @klass.weather_updated_every)

    weathers.each do |w|
      expect(w.provider).to eq(WeatherFetcher::Provider::OpenWeatherMap.provider_name)
    end

    expect(@klass.weather_updated_every).to be > 11 * 3600
    expect(@klass.weather_updated_every).to be <= 24 * 3600

    # puts weathers.to_yaml
  end

  # TODO add some tests
end
