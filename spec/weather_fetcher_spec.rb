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

  it "should return provider classes list" do
    providers = WeatherFetcher::ProviderList.providers
    providers.each do |p|
      p.should be_kind_of(Class)

      instance = p.new
      instance.should respond_to(:fetch)
    end
  end

end
