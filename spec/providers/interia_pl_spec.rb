describe "WeatherFetcher::Provider::InteriaPl", :ready => true do
  before :each do
    @defs = load_fixture('interia_pl')
    @defs.size.should > 0
  end

  it "simple fetch" do
    f = WeatherFetcher::Provider::InteriaPl.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers

    # puts weathers.to_yaml
  end
end
