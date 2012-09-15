# encoding: utf-8

require 'spec_helper'

describe WeatherFetcher do
  it "should fetch Bydgoszcz" do
    _d = { :name=>"Bydgoszcz", :country=>"Poland", :metar=>"EPBY", :coords=>{ :lat=>53.0968, :lon=>17.9777 }, :classes=>{ "OnetPl"=>{ :url=>"http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,bydgoszcz,9315.html" }, "WpPl"=>{ :url=>"http://pogoda.wp.pl/miasto,bydgoszcz,mid,1201023,mi.html" }, "InteriaPl"=>{ :url=>"http://pogoda.interia.pl/miasta?id=11666" } } }
    _res = WeatherFetcher::Fetcher.fetch(_d)

    providers = WeatherFetcher::SchedulerHelper.recommended_providers(_res)
    #puts providers.to_yaml

    providers.size.should > 0
    (providers & [WeatherFetcher::Provider::OnetPl]).size.should == 0
  end

  it "should fetch Poznan" do
    _d = { :name=>"Poznań", :country=>"Poland", :metar=>"EPPO", :coords=>{ :lat=>52.411048, :lon=>16.928329 }, :classes=>{ "OnetPl"=>{ :url=>"http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,poznan,9204.html" }, "WpPl"=>{ :url=>"http://pogoda.wp.pl/miasto,poznan,mid,1201201,mi.html" }, "InteriaPl"=>{ :url=>"http://pogoda.interia.pl/miasta?id=11875" } } }
    _res = WeatherFetcher::Fetcher.fetch(_d)
    # puts _res.collect{|r| r.provider}

    providers = WeatherFetcher::SchedulerHelper.recommended_providers(_res)
    #puts providers.inspect

    #providers.size.should == 0
    (providers & [WeatherFetcher::Provider::OnetPl]).size.should == 0
    (providers & [WeatherFetcher::Provider::WpPl]).size.should == 0
    (providers & [WeatherFetcher::Provider::InteriaPl]).size.should == 0
  end
end