#encoding: utf-8

require 'json'

module WeatherFetcher
  class Provider::OpenWeatherMapForecast < HtmlBasedProvider
    def self.provider_name
      "OpenWeatherMap"
    end

    # How often weather is updated
    def self.weather_updated_every
      12*HOUR - 240
    end

    # Url for current provider
    def url(p)
      "http://api.openweathermap.org/data/2.5/forecast/daily?lat=#{p[:coords][:lat]}&lon=#{p[:coords][:lon]}&cnt=15&mode=json&units=metric"
    end

    def can_fetch?(p)
      begin
        url(p).nil? == false
      rescue
        false
      end
    end

    def process(string)
      result = JSON.parse(string)

      # fix for empty response
      return if result.nil? or result["list"].nil?

      current_time = Time.mktime(
        Time.now.year,
        Time.now.month,
        Time.now.day,
        Time.now.hour
      )

      weather_data = Array.new

      result["list"].each do |w|
        h_day = {
          :temperature => w["temp"]["day"].to_f,
          :wind => w["speed"].to_f,
          :pressure => w["pressure"].to_f,
          :rain => nil,
          :snow => nil,
          :provider => self.class.provider_name,

          :cloud_cover => nil,
          :humidity => w["humidity"].to_i,
          :visibility => nil,

          :wwo_type => :forecast,
          :time_created => Time.now,
          :time_from => Time.at(w["dt"].to_i - 6*HOUR),
          :time_to => Time.at(w["dt"].to_i + 6*HOUR)
        }

        h_night = {
          :temperature => w["temp"]["night"].to_f,
          :wind => w["speed"].to_f,
          :pressure => w["pressure"].to_f,
          :rain => nil,
          :snow => nil,
          :provider => self.class.provider_name,

          :cloud_cover => nil,
          :humidity => w["humidity"].to_i,
          :visibility => nil,

          :wwo_type => :forecast,
          :time_created => Time.now,
          :time_from => Time.at(w["dt"].to_i + 6*HOUR),
          :time_to => Time.at(w["dt"].to_i + 18*HOUR)
        }

        weather_data << h_day
        weather_data << h_night
      end


      return WeatherData.factory(weather_data)
    end

  end
end
