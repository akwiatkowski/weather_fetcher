describe "WeatherFetcher::Provider::Wunderground" do
  before :each do
    #@defs = load_fixture('wp_pl')
    #@defs.size.should > 0
    @defs = { :metar_code => 'EPPO' }
  end

  it "simple fetch" do
    f = WeatherFetcher::Provider::Wunderground.new(@defs)
    weathers = f.fetch
    weathers.should == f.weathers

    puts weathers.to_yaml
  end
end
