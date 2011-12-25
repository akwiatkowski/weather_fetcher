describe "WeatherFetcher::Provider::WpPl", :html => true do
  before :each do
    @defs = load_fixture('wp_pl')
    @defs.size.should > 0
  end

  it "simple fetch" do
    f = WeatherFetcher::Provider::WpPl.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers

    # puts weathers.to_yaml
  end
end
