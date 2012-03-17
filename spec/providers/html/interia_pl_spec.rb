require 'spec_helper'

describe "WeatherFetcher::Provider::InteriaPl" do
  before :each do
    @defs = cities_defs
  end

  it "simple fetch" do
    f = WeatherFetcher::Provider::InteriaPl.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers

    # puts weathers.to_yaml
  end
end
