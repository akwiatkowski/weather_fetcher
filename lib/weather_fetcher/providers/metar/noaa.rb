#encoding: utf-8

module WeatherFetcher
  class Provider::Noaa < MetarProvider

    def url_for_metar(metar_city)
      u = "http://weather.noaa.gov/pub/data/observations/metar/stations/#{metar_city.upcase}.TXT"
      return u
    end

    def process(string)
      string.gsub!(/\d{4}\/\d{1,2}\/\d{1,2} \d{1,2}\:\d{1,2}\s*/, ' ')
      string.gsub!(/\n/, ' ')
      string.gsub!(/\t/, ' ')
      string.gsub!(/\s{2,}/, ' ')
      string.strip
    end

  end

end


