#encoding: utf-8

require 'nokogiri'
require 'time'

module WeatherFetcher
  class Provider::WpPl < HtmlBasedProvider

    def self.provider_name
      "Wp.pl"
    end

    def process(string)
      return WeatherData.factory(_process(string))
    end

    # Process response body and rip out weather data
    def _process(body_raw)
      data = Array.new
      b = Nokogiri::HTML(body_raw)

      weather_days = b.css(".czas")
      puts weather_days.size

      return data
    end


  end

end
