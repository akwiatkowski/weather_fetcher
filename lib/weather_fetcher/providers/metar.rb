# All ugly providers who parse even uglier html code and rip off data
module WeatherFetcher
  class Metar < HtmlBased

    TYPE = :metar

    # Get processed weather for one definition
    def fetch_and_process_single(d)
      url = url_for_metar(d[:metar_code])
      body = fetch_url(url)
      processed = process(body)
      return processed
    end

    def self.provider_name
      "Metar"
    end

    def url_for_metar(metar_city)
      raise 'Not implemented'
    end

  end
end