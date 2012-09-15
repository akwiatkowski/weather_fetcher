# encoding: utf-8

require 'spec_helper'

describe "WeatherFetcher" do
  it "should fetch using defitnion" do
    _d = { :name=>"Mogilno", :country=>"Poland", :coords=>{ :lat=>52.658612, :lon=>17.955923 }, :classes=>{ "OnetPl"=>{ :url=>"http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,mogilno,9224.html" }, "WpPl"=>{ :url=>"http://pogoda.wp.pl/miasto,mogilno,mid,1201149,mi.html" }, "InteriaPl"=>{ :url=>"http://pogoda.interia.pl/miasta?id=11817" } } }
    WeatherFetcher::Fetcher.fetch(_d)
  end
end