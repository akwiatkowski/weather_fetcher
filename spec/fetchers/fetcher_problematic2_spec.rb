# encoding: utf-8

require 'spec_helper'

fn = File.open(File.join(Dir.pwd, 'spec', 'fixtures', "world_weather_api.rb"))
if File.exist?(fn)
  require fn
  WeatherFetcher::Provider::WorldWeatherOnline.api = WORLD_WEATHER_API
end

describe WeatherFetcher do
  it "should fetch south pole using WeatherFetcher::Provider::WorldWeatherOnline" do
    _d = {
      :name => "Amundsen-Scott",
      :country => "Antarctica",
      :metar => "NZSP",
      :coords => {
        :lat => -89.983333,
        :lon => 179.983333
      },
      :id => 24
    }

    _p = WeatherFetcher::Provider::WorldWeatherOnline.new(_d)
    _p.fetch
    _res = _p.weathers
    expect(_res).to be_kind_of(Array)

    _res.each do |wd|
      if wd.provider == WeatherFetcher::MetarProvider.provider_name
        expect(wd.is_metar?).to be_truthy
      end

      if wd.provider == "MetarProvider"
        expect(wd.is_metar?).to be_truthy
      end

      expect(wd.city).to eq("Amundsen-Scott")
    end
  end
end