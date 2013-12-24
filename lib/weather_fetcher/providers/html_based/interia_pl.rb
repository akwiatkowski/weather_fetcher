#encoding: utf-8

require 'nokogiri'

module WeatherFetcher
  class Provider::InteriaPl < HtmlBasedProvider

    def self.provider_name
      "Interia.pl"
    end

    def process(string)
      WeatherData.factory(_process(string))
    end

    # Process response body and rip out weather data
    def _process(body_raw)
      data = Array.new
      b = Nokogiri::HTML(body_raw)

      weather_days = b.css(".weather-forecast-day")
      weather_days.each do |d|
        klass = d.attribute("class").value
        klass =~ /(\d{4})-(\d{1,2})-(\d{1,2})/
        t = Time.local($1.to_i, $2.to_i, $3.to_i)

        weather_list = d.css("li.weather-entry")
        weather_list.each do |w|
          h = Hash.new

          hour = w.css(".entry-hour > .hour").children.first.to_s.to_i
          min = w.css(".entry-hour > .minute").children.first.to_s.to_i
          time_from = t + hour * 3600 + min * 60

          puts time_from
        end

      end

      #days_count = 3
      #(0...days_count).each do |di|
      #  day_t = unix_time_today + 24*3600*di
      #  day_s = day_t.strftime("%Y-%m-%d")
      #
      #  css_selector = ".weather-forecast-day.#{day_s} > li.weather-entry"
      #  puts css_selector
      #
      #  weather_list = b.css(css_selector)
      #  weather_list.each do |w|
      #    h = Hash.new
      #
      #    hour = w.css(".entry-hour > .hour").children.first.to_s.to_i
      #    min = w.css(".entry-hour > .minute").children.first.to_s.to_i
      #    time_from = day_t + hour * 3600 + min * 60
      #
      #    puts time_from
      #
      #  end
      #end


      #h = {
      #  :time_created => Time.now,
      #  :time_from => time_from,
      #  :time_to => time_from + 3600,
      #  :temperature => temperatures[1 + i][0].to_f,
      #  :pressure => pressures[0][0].to_f,
      #  :wind_kmh => winds[0][0].to_f,
      #  :wind => winds[0][0].to_f / 3.6,
      #  :snow => nil, #snows[0][0].to_f,
      #  :rain => rains[0][0].gsub(/,/, '.').to_f,
      #  :provider => self.class.provider_name
      #}

      return
    end
  end
end
