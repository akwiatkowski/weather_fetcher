require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# providers
#require File.expand_path(File.dirname(__FILE__) + '/providers/onet_pl_spec')

describe "WeatherFetcher" do
  it "simple stuff" do
    WeatherFetcher.class.should == Module
  end
end
