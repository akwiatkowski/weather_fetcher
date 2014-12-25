# encoding: utf-8

require 'spec_helper'

describe WeatherFetcher do
  #it "should fetch Bydgoszcz" do
  #  _d = { :name => "Bydgoszcz", :country => "Poland", :metar => "EPBY", :coords => { :lat => 53.0968, :lon => 17.9777 }, :classes => { "OnetPl" => { :url => "http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,bydgoszcz,9315.html" }, "WpPl" => { :url => "http://pogoda.wp.pl/miasto,bydgoszcz,mid,1201023,mi.html" }, "InteriaPl" => { :url => "http://pogoda.interia.pl/miasta?id=11666" } } }
  #  _res = WeatherFetcher::Fetcher.fetch(_d)
  #
  #  providers = WeatherFetcher::SchedulerHelper.recommended_providers(_res)
  #  # puts providers.to_yaml
  #
  #  expect(providers.size).to be > 0
  #  expect(providers).not_to include(WeatherFetcher::Provider::OnetPl)
  #end

  it "should fetch Poznan" do
    _d = {
      :name => "Poznań",
      :country => "Poland",
      :metar => "EPPO",
      :coords => {
        :lat => 52.411048,
        :lon => 16.928329
      },
      :classes => {
        "OnetPl" => {
          :url => "http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,poznan,9204.html"
        },
        # should use longterm
        "WpPl" => {
          :url => "http://pogoda.wp.pl/cid,43384,miasto,Pozna%C5%84,dlugoterminowa.html"
        },
        "InteriaPl" => {
          :url => "http://pogoda.interia.pl/prognoza-szczegolowa-bydgoszcz,cId,3696"
        }
      }
    }

    _res = WeatherFetcher::Fetcher.fetch(_d)
    puts _res.collect{|r| r.provider}

    providers = WeatherFetcher::SchedulerHelper.recommended_providers(_res)
    #puts providers.inspect

    #providers.size.should == 0
    expect(providers).not_to include(WeatherFetcher::Provider::OnetPl)
    expect(providers).not_to include(WeatherFetcher::Provider::InteriaPl)
    # some problem with wp.pl, have to use longterm
    expect(providers).not_to include(WeatherFetcher::Provider::WpPl)

  end
end