require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "WeatherFetcher" do
  it "simple stuff" do
    WeatherFetcher.class.should == Module
  end

  it "should accept only Array or Hash definitions" do
    lambda { WeatherFetcher::Provider.new("ble") }.should raise_error
    lambda { WeatherFetcher::Provider.new(1) }.should raise_error
    lambda { WeatherFetcher::Provider.new() }.should_not raise_error
    lambda { WeatherFetcher::Provider.new([]) }.should_not raise_error
    lambda { WeatherFetcher::Provider.new({}) }.should_not raise_error
  end

end
