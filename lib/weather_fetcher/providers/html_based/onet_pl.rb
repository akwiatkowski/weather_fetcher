#encoding: utf-8

require 'nokogiri'
require 'time'

module WeatherFetcher
  class Provider::OnetPl < HtmlBasedProvider

    def self.provider_name
      "Onet.pl"
    end

    def process(string)
      a = Array.new
      a += WeatherData.factory(_process_body_long_term(string))
      return a
    end

    # Process response body and rip out weather data, details
    def _process_body_long_term(body_raw)
      data = Array.new
      b = Nokogiri::HTML(body_raw)

      weather_days = b.css(".day-longterm")
      weather_days.each do |weather_day|
        time_from = Time.parse(weather_day.css("time").attribute("datetime").value.to_s)
        temp = weather_day.css(".temp").children.first.to_s.to_f

        desc = weather_day.css(".details").children.collect { |d| d.to_s.gsub(/\n/, "").gsub(/\t/, "") }
        pressure = desc[3].to_f
        wind = desc[7].to_f
        rain = desc[10].gsub(/,/, '.').to_f

        h = {
          :time_created => Time.now,
          :time_from => time_from,
          :time_to => time_from + 24*3600,
          :temperature => temp,
          #:feel_temperature => feel_temp,
          :pressure => pressure,
          :wind_kmh => wind,
          :wind => wind / 3.6,
          #  :snow => nil, #snows[0][0].to_f,
          :rain => rain,
          #:cloud_cover => cloud_cover,
          #:humidity => humidity,
          :provider => self.class.provider_name
        }
        data << h

        # puts h.inspect
      end
      return data
    end

  end

end

