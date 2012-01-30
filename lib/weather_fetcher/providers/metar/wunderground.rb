#encoding: utf-8

module WeatherFetcher
  class Provider::Wunderground < MetarProvider

    def url_for_metar(metar_city)
      u = "http://www.wunderground.com/Aviation/index.html?query=#{metar_city.upcase}"
      return u
    end

    def process(string)
      reg = /<div class=\"textReport\">\s*METAR\s*([^<]*)<\/div>/
      string = string.scan(reg).first.first
      string.gsub!(/\n/, ' ')
      string.gsub!(/\t/, ' ')
      string.gsub!(/\s{2,}/, ' ')
      @metars << string.strip
    end

  end

end


