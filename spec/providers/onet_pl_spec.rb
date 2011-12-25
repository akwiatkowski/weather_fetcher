describe "WeatherFetcher::Provider::OnetPl" do
  before :each do
    @defs = load_fixture('onet_pl')
    @defs.size.should > 0
    puts @defs.inspect
    puts "*"*100
  end

  it "simple stuff" do

    f = WeatherFetcher::Provider::OnetPl.new(@defs)
    f.fetch

  end
end
