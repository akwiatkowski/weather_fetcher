# encoding: utf-8

require 'spec_helper'

describe "WeatherFetcher" do
  it "should fetch Mogilno" do
    _d = { :name=>"Mogilno", :country=>"Poland", :coords=>{ :lat=>52.658612, :lon=>17.955923 }, :classes=>{ "OnetPl"=>{ :url=>"http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,mogilno,9224.html" }, "WpPl"=>{ :url=>"http://pogoda.wp.pl/miasto,mogilno,mid,1201149,mi.html" }, "InteriaPl"=>{ :url=>"http://pogoda.interia.pl/miasta?id=11817" } } }
    _res = WeatherFetcher::Fetcher.fetch(_d)
    _res.should be_kind_of(Array)
    _res.size.should > 0
  end

  it "should fetch Bydgoszcz" do
    _d = { :name=>"Bydgoszcz", :country=>"Poland", :metar=>"EPBY", :coords=>{ :lat=>53.0968, :lon=>17.9777 }, :classes=>{ "OnetPl"=>{ :url=>"http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,bydgoszcz,9315.html" }, "WpPl"=>{ :url=>"http://pogoda.wp.pl/miasto,bydgoszcz,mid,1201023,mi.html" }, "InteriaPl"=>{ :url=>"http://pogoda.interia.pl/miasta?id=11666" } } }
    _res = WeatherFetcher::Fetcher.fetch(_d)
    _res.should be_kind_of(Array)
    _res.size.should > 0
  end
end