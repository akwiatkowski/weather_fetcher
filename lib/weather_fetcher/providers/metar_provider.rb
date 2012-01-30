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
    def fetch_and_process_single(d)
      url = url_for_metar(d[:metar_code])
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

  end
end