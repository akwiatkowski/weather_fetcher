#encoding: utf-8

module WeatherFetcher
  class Provider::OnetPl < HtmlBasedProvider

    def self.provider_name
      "Onet.pl"
    end

    def process(string)
      a = Array.new
      a += WeatherData.factory(_process_body(string))
      return a
    end

    # Process response body and rip out weather data, details
    def _process_body(body_raw)

      body_tmp = body_raw.downcase
      body = body_tmp

      times = body.scan(/<span class=\"time\">godz. <strong>(\d+)-(\d+)/i)
      temperatures = body.scan(/<span class="temp">\s*(-*\d+)[^<]+<\/span>/i)
      pressures = body.scan(/(\d*)\s*hpa/i)
      winds = body.scan(/(\d*)\s*km\/h/)
      # no more snow :(
      #snows = body.scan(/nieg:<\/td><td class=\"[^"]*\">\s*([0-9.]*)\s*mm</)
      snow = []
      #rains = body.scan(/Deszcz:\s*<\/label>\s*([0-9,]+)\s*mm/i)
      rains = body.scan(/Deszcz:[^0-9]*([0-9,]+)\s*mm/i)

      unix_time_today = Time.mktime(
        Time.now.year,
        Time.now.month,
        Time.now.day,
        0, 0, 0, 0)

      # should be ok
      # puts times.size, temperatures.size, pressures.size, winds.size, rains.size
      # puts times.inspect, temperatures.inspect, pressures.inspect, winds.inspect, rains.inspect

      data = Array.new

      # today
      (0..3).each do |i|
        h = {
          :time_created => Time.now,
          :time_from => unix_time_today + times[i][0].to_i * 3600,
          :time_to => unix_time_today + times[i][1].to_i * 3600,
          :temperature => temperatures[1 + i][0].to_f,
          :pressure => pressures[0][0].to_f,
          :wind_kmh => winds[0][0].to_f,
          :wind => winds[0][0].to_f / 3.6,
          :snow => nil, #snows[0][0].to_f,
          :rain => rains[0][0].gsub(/,/, '.').to_f,
          :provider => self.class.provider_name
        }
        h[:time_to] += 24*3600 if h[:time_to] < h[:time_from]

        data << h
      end

      # tomorrow
      (4..7).each do |i|
        h = {
          :time_created => Time.now,
          :time_from => unix_time_today + times[i][0].to_i * 3600 + 24*3600,
          :time_to => unix_time_today + times[i][1].to_i * 3600 + 24*3600,
          :temperature => temperatures[6 + i][0].to_f,
          :pressure => pressures[1][0].to_f,
          :wind_kmh => winds[1][0].to_f,
          :wind => winds[1][0].to_f / 3.6,
          :snow => nil, #snows[0][0].to_f,
          :rain => rains[1][0].gsub(/,/, '.').to_f,
          :provider => self.class.provider_name
        }
        h[:time_to] += 24*3600 if h[:time_to] < h[:time_from]

        data << h
      end
      # puts data.to_yaml

      # longer
      dates = body.scan(/<time datetime=\"(\d{4})-(\d{1,2})-(\d{1,2})\">/i)

      (0..10).each do |i|
        unix_time = Time.mktime(
          dates[i][0].to_i,
          dates[i][1].to_i,
          dates[i][2].to_i
        )
        # puts unix_time, dates[i].inspect

        h = {
          :time_created => Time.now,
          :time_from => unix_time,
          :time_to => unix_time + 24*3600,
          :temperature => temperatures[13 + i][0].to_f,
          :pressure => pressures[3 + i][0].to_f,
          :wind_kmh => winds[3 + i][0].to_f,
          :wind => winds[3 + i][0].to_f / 3.6,
          :snow => nil, #snows[0][0].to_f,
          :rain => rains[3 + i][0].gsub(/,/, '.').to_f,
          :provider => self.class.provider_name
        }
        h[:time_to] += 24*3600 if h[:time_to] < h[:time_from]

        data << h
      end
      # puts data.to_yaml

      return data
    end

  end

end

