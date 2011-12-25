require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "WeatherFetcher" do
  it "simple stuff" do
    WeatherFetcher.class.should == Module
    
    WeatherFetcher::Provider::OnetPl
  end
end
