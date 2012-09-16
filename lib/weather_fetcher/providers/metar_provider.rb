require 'simple_metar_parser'

# All ugly providers who parse even uglier html code and rip off data
module WeatherFetcher
  class MetarProvider < HtmlBasedProvider

    TYPE = :metar
    # treat metars as not current when time_from is not within time range
    MAX_METAR_TIME_THRESHOLD = 4*3600

    # Get processed weather for one definition
    def fetch_and_process_single(p)
      return nil unless can_fetch?(p)

      @pre_download = Time.now
      url = url_for_metar(metar(p))
      body = fetch_url(url)
      @pre_process = Time.now
      metars = process(body)
      metars = [metars] unless metars.kind_of?(Array)
      processed = Array.new

      metars.each do |m|
        m = SimpleMetarParser::Parser.parse(m)

        if m.valid? and (m.time_from - Time.now).abs < MAX_METAR_TIME_THRESHOLD
          processed << {
            :time_created => Time.now,
            :time_from => m.time_from,
            :time_to => m.time_to,
            :temperature => m.temperature.degrees,
            :pressure => m.pressure.hpa,
            :wind_kmh => m.wind.kmh,
            :wind => m.wind.mps,
            :snow_metar => m.specials.snow_metar,
            :rain_metar => m.specials.rain_metar,
            :provider => self.class.provider_name,
            :metar_string => m.raw
          }
        end

      end

      processed = WeatherData.factory(processed)
      @post_process = Time.now
      store_time_costs(processed)
      store_city_definition(processed, p)

      return processed
    end

    def self.provider_name
      "MetarProvider"
    end

    def url_for_metar(metar_city)
      raise 'Not implemented'
    end

    # Metar
    def metar(p)
      p[:metar]
    end

    def can_fetch?(p)
      begin
        metar(p).nil? == false
      rescue
        false
      end
    end

    # How often weather is updated
    def self.weather_updated_every
      10*60
    end

  end
end