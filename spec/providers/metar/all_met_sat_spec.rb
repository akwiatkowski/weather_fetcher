require 'spec_helper'

describe WeatherFetcher::Provider::AllMetSat do
  before :each do
    @defs = cities_defs_only_metar
  end

  it "simple fetch" do
    f = WeatherFetcher::Provider::AllMetSat.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers

    # puts weathers.to_yaml
  end
end
