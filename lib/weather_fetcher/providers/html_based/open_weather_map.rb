#encoding: utf-8

require 'json'

# http://openweathermap.org/

module WeatherFetcher
  class Provider::OpenWeatherMap < HtmlBasedProvider
    def self.provider_name
      "OpenWeatherMap"
    end

    # How often weather is updated
    def self.weather_updated_every
      12*HOUR - 240
    end

    # This provider could use API key
    # but this version won't
    def self.api=(_api)
      @@api = _api
    end

    def self.api
      return nil unless defined?(@@api)
      @@api
    end

    # Url for current provider
    def url(p)
      "http://api.openweathermap.org/data/2.5/weather?lat=#{p[:coords][:lat]}&lon=#{p[:coords][:lon]}&units=metric"
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
      return if result.nil? or result["main"].nil? or result["main"]["temp"].nil?

      current_time = Time.mktime(
        Time.now.year,
        Time.now.month,
        Time.now.day,
        Time.now.hour
      )

      h = {
        :temperature => result["main"]["temp"].to_f,
        :wind => result["wind"]["speed"].to_f,
        :pressure => result["main"]["pressure"].to_f,
        :rain => nil,
        :snow => nil,
        :provider => self.class.provider_name,

        :cloud_cover => nil,
        :humidity => result["main"]["humidity"].to_i,
        :visibility => nil,

        :wwo_type => :current,
        :time_created => Time.now,
        :time_from => current_time,
        :time_to => current_time + 3600
      }

      return WeatherData.factory(h)
    end

  end
end
