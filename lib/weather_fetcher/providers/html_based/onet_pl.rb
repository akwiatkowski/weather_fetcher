#encoding: utf-8

module WeatherFetcher
  class Provider::OnetPl < HtmlBased

    def self.provider_name
      "Onet.pl"
    end

    def process(string)
      @weathers += _process_details(string)
      @weathers += _process_daily(string)
    end

    # Process response body and rip out weather data, details
    def _process_details(body_raw)

      body_tmp = body_raw.downcase
      #    if body_tmp =~ /szczeg..owa(.*)Prognoza/
      #      body = $1
      #    else
      #      return []
      #    end
      body = body_tmp

      temperatures = body.scan(/<b\s*title=\"temperatura\">([^<]*)<\/b>/)
      pressures = body.scan(/\>(\d*)\s*hpa\s*\</)
      winds = body.scan(/(\d*)\s*km\/h/)
      snows = body.scan(/nieg:<\/td><td class=\"[^"]*\">\s*([0-9.]*)\s*mm</)
      rains = body.scan(/eszcz:<\/td><td class=\"[^"]*\">\s*([0-9.]*)\s*mm</)

      # time now
      time_now = body.scan(/<span class="ar2b gold">teraz <\/span><span class="ar2 gold">(\d*)-(\d*)<\/span>/)
      # time soon
      time_soon = body.scan(/<span class="ar2b gold">wkr.tce <\/span><span class="ar2 gold">(\d*)-(\d*)<\/span>/)

      unix_time_today = Time.mktime(
        Time.now.year,
        Time.now.month,
        Time.now.day,
        0, 0, 0, 0)

      unix_time_now_from = unix_time_today + 3600 * time_now[0][0].to_i
      unix_time_now_to = unix_time_today + 3600 * time_now[0][1].to_i
      if time_now[0][1].to_i < time_now[0][0].to_i
        # next day
        unix_time_now_to += 24 * 3600
      end

      unix_time_soon_from = unix_time_today + 3600 * time_soon[0][0].to_i
      unix_time_soon_to = unix_time_today + 3600 * time_soon[0][1].to_i
      if time_soon[0][1].to_i < time_soon[0][0].to_i
        # next day
        unix_time_soon_to += 24 * 3600
      end
      if time_now[0][0].to_i > time_soon[0][0].to_i
        # time soon is whole new day
        unix_time_soon_from += 24 * 3600
        unix_time_soon_to += 24 * 3600
      end

      data = [
        {
          :time_created => Time.now,
          :time_from => unix_time_now_from,
          :time_to => unix_time_now_to,
          :temperature => temperatures[0][0].to_f,
          :pressure => pressures[0][0].to_f,
          :wind_kmh => winds[0][0].to_f,
          :wind => winds[0][0].to_f / 3.6,
          :snow => snows[0][0].to_f,
          :rain => rains[0][0].to_f,
          :provider => self.class.provider_name
        },
        {
          :time_created => Time.now,
          :time_from => unix_time_soon_from,
          :time_to => unix_time_soon_to,
          :temperature => temperatures[1][0].to_f,
          :pressure => pressures[1][0].to_f,
          :wind_kmh => winds[1][0].to_f,
          :wind => winds[1][0].to_f / 3.6,
          :snow => snows[1][0].to_f,
          :rain => rains[1][0].to_f,
          :provider => self.class.provider_name
        }
      ]

      return data
    end

    # Process response body and rip out weather data, daily
    def _process_daily(body_raw)

      body_tmp = body_raw.downcase
      body = body_tmp

      #times = time_now = body.scan(/<span class=\"ar2 gold\">([0-9.]+)<\/span>/)
      times = body.scan(/<span class=\"ar2 gold\">(\d{1,2})\.(\d{1,2})\.(\d{4})<\/span>/)
      times = times.collect { |t|
        t_from = Time.mktime(
          t[2].to_i,
          t[1].to_i,
          t[0].to_i,
          0, 0, 0, 0)

        { :time_from => t_from, :time_to => t_from + 24*3600 }
      }
      #puts times.size
      #puts times.inspect

      temperatures = body.scan(/<span title=\"temperatura w dzie.\">([-.0-9]+)<\/span>\s*<span title=\"temperatura w nocy\"[^>]*>([-.0-9]+)<\/span>/)
      temperatures = temperatures.collect { |t|
        { :temperature_night => t[1].to_f, :temperature_day => t[0].to_f, :temperature => (t[0].to_f + t[1].to_f)/2.0 }
      }
      #puts temperatures.size
      #puts temperatures.inspect
      #exit!

      #pressures = body.scan(/>(\d+)\s*hpa</)
      pressures = body.scan(/(\d+)\s*hpa/)
      pressures = pressures.collect { |t| t[0].to_i }
      # puts pressures.inspect

      # wind speed in m/s
      winds = body.scan(/(\d+)\s*km\/h/)
      winds = winds.collect { |t| t[0].to_f / 3.6 }
      # puts winds.inspect

      snows = body.scan(/nieg:<\/td><td class="[^"]*">([0-9.]*)\s*mm</)
      snows = snows.collect { |t| t[0].to_f }
      # puts snows.inspect

      rains = body.scan(/eszcz:<\/td><td class=\"[^"]*\">\s*([0-9.]*)\s*mm</)
      rains = rains.collect { |t| t[0].to_f }
      # puts rains.inspect


      data = Array.new
      # temperatures array because some last times is for detailed weather prediction
      # not for days
      (0...(temperatures.size)).each do |i|
        h = {
          :time_created => Time.now,
          :time_from => times[i][:time_from],
          :time_to => times[i][:time_to],
          :temperature => temperatures[i][:temperature],
          :pressure => pressures[i],
          :wind_kmh => winds[i] * 3.6,
          :wind => winds[i],
          :snow => snows[i],
          :rain => rains[i],
          :provider => self.class.provider_name,
          :weather_provider_id => id
        }
        data << h
      end

      return data
    end

  end


  #WeatherFetcher::ProviderList.register_provider(Provider::OnetPl)
end

