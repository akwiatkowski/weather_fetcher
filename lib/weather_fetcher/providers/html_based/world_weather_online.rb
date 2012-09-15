#encoding: utf-8

require 'json'

module WeatherFetcher
  class Provider::WorldWeatherOnline < HtmlBasedProvider
    def self.provider_name
      "WorldWeatherOnline"
    end

    # How often weather is updated
    def self.weather_updated_every
      12*HOUR - 240
    end

    # This provider required API key
    def self.api=(_api)
      @@api = _api
    end

    def self.api
      @@api
    end

    # Url for current provider
    def url(p)
      "http://free.worldweatheronline.com/feed/weather.ashx?key=#{@@api}&q=#{p[:coords][:lat]},#{p[:coords][:lon]}&num_of_days=2&format=json"
    end

    def can_fetch?(p)
      return false if not defined? @@api

      begin
        url(p).nil? == false
      rescue
        false
      end
    end

    def process(string)
      result = JSON.parse(string)

      # weather archives as processing output
      weather_archives = Array.new

      # fix for empty response
      return if result.nil? or result["data"].nil? or result["data"]["current_condition"].nil?

      # current conditions
      current = result["data"]["current_condition"].first
      current_time = Time.create_time_from_string_12_utc(nil, current["observation_time"])

      h = process_node(current)
      h.merge(
        {
          :time_created => Time.now,
          :time_from => current_time - 3600,
          :time_to => current_time
        }
      )
      weather_archives << h

      # prediction
      predictions = result["data"]["weather"]
      predictions.each do |p|
        h = process_node(p)
        h[:pressure] = nil

        # create 2 records using tempMinC and tempMaxC
        hl = h.merge(
          {
            :time_created => Time.now,
            :time_from => Time.create_time_from_string(p["date"], "0:00") - 4 * 3600,
            :time_to => Time.create_time_from_string(p["date"], "0:00") + 8 * 3600,
            :temperature => p["tempMinC"].to_i
          }
        )
        weather_archives << hl

        # and high
        hh = h.merge(
          {
            :time_from => Time.create_time_from_string(p["date"], "0:00") + 8 * 3600,
            :time_to => Time.create_time_from_string(p["date"], "0:00") + 20 * 3600,
            :temperature => p["tempMaxC"].to_i
          }
        )
        weather_archives << hh

      end

      return WeatherData.factory(weather_archives)

    end


    # Process json node to Hash for AR
    def process_node(node)
      # http://www.worldweatheronline.com/marine-weather-api.aspx
      return {
        :temperature => node["temp_C"].to_i,
        :wind => node["windspeedKmph"].to_f / 3.6,
        :pressure => node["pressure"].to_f,
        :rain => node["precipMM"].to_f,
        :snow => nil,
        :provider => self.class.provider_name,

        :cloud_cover => node["cloudcover"].to_f,
        :humidity => node["humidity"].to_f,
        :visibility => node["visibility"].to_f,
      }
    end

  end
end
