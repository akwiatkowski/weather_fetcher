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

      current_day_time = unix_time_today
      weather_days = b.css(".obszar")
      weather_days.each do |w|
        time = w.css(".czas").children.first.to_s.gsub(/\s/, '')
        time =~ /(\d{2}):(\d{2})-(\d{2}):(\d{2})/
        time_from = current_day_time + 3600*$1.to_i + 60*$2.to_i
        time_to = current_day_time + 3600*$3.to_i + 60*$4.to_i

        temp_night = w.css(".tempNoc").children.first
        temp_day = w.css(".tempDzien").children.first
        temp = nil
        if temp_night
          temp = temp_night.children.first.to_s.to_f
        end
        if temp_day
          temp = temp_day.children.first.to_s.to_f
        end


        h = {
          :time_created => Time.now,
          :time_from => time_from,
          :time_to => time_to,
          :temperature => temp,
          #:feel_temperature => feel_temp,
          #:pressure => pressure,
          #:wind_kmh => wind,
          #:wind => wind / 3.6,
          #  :snow => nil, #snows[0][0].to_f,
          #:rain => rain,
          #:cloud_cover => cloud_cover,
          #:humidity => humidity,
          :provider => self.class.provider_name
        }

        puts h.inspect

        data << h
      end

      return data
    end


  end

end
