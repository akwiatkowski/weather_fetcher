#encoding: utf-8

module WeatherFetcher
  class Provider::AviationWeather < MetarProvider

    def url_for_metar(metar_city)
      u = "http://aviationweather.gov/adds/metars/index.php?submit=1&station_ids=#{metar_city.upcase}"
      return u
    end

    def process(string)
      reg = /\">([^<]*)<\/FONT>/
      data = string.scan(reg).first
      if not data.nil? and not data.first.nil?
        string = data.first
        string.gsub!(/\n/, ' ')
        string.gsub!(/\t/, ' ')
        string.gsub!(/\s{2,}/, ' ')
        @metars << string.strip
      end

      @metars
    end

  end

end


