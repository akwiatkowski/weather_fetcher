describe "WeatherFetcher::Provider::Noaa", :ready => false do
  before :each do
    #@defs = load_fixture('wp_pl')
    #@defs.size.should > 0
    @defs = { :metar_code => 'EPPO' }
  end

  it "simple fetch" do
    f = WeatherFetcher::Provider::Noaa.new(@defs)
    weathers = f.fetch
    weathers.should == f.metars

    # puts weathers.to_yaml
  end
end
