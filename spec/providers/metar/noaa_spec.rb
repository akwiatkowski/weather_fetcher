require 'spec_helper'

describe WeatherFetcher::Provider::Noaa do
  before :each do
    @defs = cities_defs_only_metar
  end

  it "simple fetch" do
    f = WeatherFetcher::Provider::Noaa.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers
    #puts weathers.to_yaml
    #puts f.weathers.to_yaml
  end
end
