#encoding: utf-8

module WeatherFetcher
  class Provider::AllMetSat < MetarProvider
    # this provider is turned off because long response time
    # typical website response - 5s
    SLOW = 5.0

    def url_for_metar(metar_city)
      u = "http://pl.allmetsat.com/metar-taf/polska.php?icao=#{metar_city.upcase}"
      return u
    end

    def process(string)
      reg = /<b>METAR:<\/b>([^<]*)<br>/
      string = string.scan(reg).first.first
      string.gsub!(/\n/, ' ')
      string.gsub!(/\t/, ' ')
      string.gsub!(/\s{2,}/, ' ')
      string.strip
    end

  end

end


