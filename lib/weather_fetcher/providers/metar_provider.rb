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
      processed = process(body)

      processed.each do |m|
        #puts MetarParser.parse(m)
        # m = SimpleMetarParser::Parser.parse(metar_string)
        puts m
      end

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

  end
end