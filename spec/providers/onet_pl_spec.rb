require 'spec_helper'

describe "WeatherFetcher::Provider::OnetPl", :ready => true do
  before :each do
    @defs = load_fixture('main')
    @defs.size.should > 0
  end

  it "simple fetch" do
    f = WeatherFetcher::Provider::OnetPl.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers
    weathers.size.should > 1
  end
end
