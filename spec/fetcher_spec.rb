# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "WeatherFetcher" do
  it "use one method to fetch from all providers" do
    h = {
      :name => 'Poznań',
      :country => 'Poland',
      :metar => 'EPPO',
      :coords => {
        :lat => 52.411048,
        :lon => 16.928329
      },
      :classes => {
        'OnetPl' => {
          :url => 'http://pogoda.onet.pl/0,198,38,poznan,miasto.html'
        },
        'WpPl' => {
          :url => 'http://pogoda.wp.pl/miasto,poznan,mid,1201201,mi.html'
        },
        'InteriaPl' => {
          :url => 'http://pogoda.interia.pl/miasta?id=11875'
        }
      }
    }
    WeatherFetcher::Fetcher.fetch(h)
  end


end