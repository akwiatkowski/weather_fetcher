# encoding: utf-8

require 'spec_helper'

fn = File.open(File.join(Dir.pwd, 'spec', 'fixtures', "world_weather_api.rb"))
if File.exist?(fn)
  require fn
  WeatherFetcher::Provider::WorldWeatherOnline.api = WORLD_WEATHER_API
end

describe WeatherFetcher do
  it "should fetch Mogilno" do
    _d = {
      :name => "Mogilno",
      :country => "Poland",
      :coords => {
        :lat => 52.658612,
        :lon => 17.955923
      },
      :classes => {
        "OnetPl" => {
          :url => "http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,mogilno,9224.html"
        },
        "WpPl" => {
          :url => "http://pogoda.wp.pl/miasto,mogilno,mid,1201149,mi.html"
        },
        "InteriaPl" => {
          :url => "http://pogoda.interia.pl/miasta?id=11817"
        }
      }
    }

    _res = WeatherFetcher::Fetcher.fetch(_d)
    expect(_res.size).to be > 0
    expect(_res).to be_kind_of(Array)

    _res.each do |wd|
      expect(wd.city).to eq("Mogilno")
    end
  end

  it "should fetch Bydgoszcz" do
    _d = {
      :name => "Bydgoszcz",
      :country => "Poland",
      :metar => "EPBY",
      :coords => {
        :lat => 53.0968,
        :lon => 17.9777
      },
      :classes => {
        "OnetPl" => {
          :url => "http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,bydgoszcz,9315.html"
        },
        "WpPl" => {
          :url => "http://pogoda.wp.pl/miasto,bydgoszcz,mid,1201023,mi.html"
        },
        "InteriaPl" => {
          :url => "http://pogoda.interia.pl/miasta?id=11666"
        }
      }
    }

    _res = WeatherFetcher::Fetcher.fetch(_d)
    expect(_res.size).to be > 0
    expect(_res).to be_kind_of(Array)

    _res.each do |wd|
      expect(wd.city).to eq("Bydgoszcz")
    end
  end

  it "should fetch Bydgoszcz using WeatherFetcher::Provider::WorldWeatherOnline" do
    _d = {
      :name => "Bydgoszcz",
      :country => "Poland",
      :metar => "EPBY",
      :coords => {
        :lat => 53.0968,
        :lon => 17.9777
      },
      :classes => {
        "OnetPl" => {
          :url => "http://pogoda.onet.pl/prognoza-pogody/dzis/europa,polska,bydgoszcz,9315.html"
        },
        "WpPl" => {
          :url => "http://pogoda.wp.pl/miasto,bydgoszcz,mid,1201023,mi.html"
        },
        "InteriaPl" => {
          :url => "http://pogoda.interia.pl/miasta?id=11666"
        }
      }
    }

    _p = WeatherFetcher::Provider::WorldWeatherOnline.new(_d)
    _p.fetch
    _res = _p.weathers
    expect(_res.size).to be > 0
    expect(_res).to be_kind_of(Array)

    _res.each do |wd|
      unless wd.pressure.nil?
        expect(wd.pressure).to be > 900.0
        expect(wd.pressure).to be < 1100.0
      end

      expect(wd.city).to eq("Bydgoszcz")
    end

    # puts _res.to_yaml
  end
end