require 'simple_metar_parser'

# All ugly providers who parse even uglier html code and rip off data
module WeatherFetcher
  class MetarProvider < HtmlBasedProvider

    TYPE = :metar

    def initialize(*args)
      @metars = Array.new
      super(*args)
    end

    attr_reader :metars

    # Get processed weather for one definition
    def fetch_and_process_single(p)
      return nil unless can_fetch?(p)

      url = url_for_metar(metar(p))
      body = fetch_url(url)
      metars = process(body)
      processed = Array.new

      metars.each do |m|
        m = SimpleMetarParser::Parser.parse(m)

        # if m.valid?
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
          :provider => self.class.provider_name
        }
        # end

      end

      return WeatherData.factory(processed)
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

  end
end