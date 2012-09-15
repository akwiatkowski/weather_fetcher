#encoding: utf-8

module WeatherFetcher
  class Provider::Wunderground < MetarProvider

    def url_for_metar(metar_city)
      u = "http://www.wunderground.com/Aviation/index.html?query=#{metar_city.upcase}"
      return u
    end

    def process(string)
      reg = /<div class=\"textReport\">\s*METAR\s*([^<]*)<\/div>/
      _s = string.scan(reg)
      return nil if _s.size == 0
      string = _s.first.first
      string.gsub!(/\n/, ' ')
      string.gsub!(/\t/, ' ')
      string.gsub!(/\s{2,}/, ' ')
      string.strip
    end

  end

end


