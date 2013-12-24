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
          hour = w.css(".entry-hour > .hour").children.first.to_s.to_i
          min = w.css(".entry-hour > .minute").children.first.to_s.to_i
          time_from = t + hour * 3600 + min * 60

          temp = w.css(".forecast-top > .forecast-temp").children.first.to_s.to_f
          feel_temp = w.css(".forecast-top > .forecast-feeltemp").children.first.to_s.gsub(/Odczuwalna/, "").to_f
          wind = w.css(".wind-speed > .speed-value").children.first.to_s.to_f
          rain = w.css("span.entry-precipitation-value.rain").children.first.to_s.gsub(/,/, ".").to_f
          snow = w.css("span.entry-precipitation-value.snow").children.first
          if snow
            snow = snow.to_s.gsub(/,/, ".").to_f
          else
            snow = nil
          end
          cloud_cover = w.css("span.entry-precipitation-value.cloud-cover").children.first.to_s.to_f
          humidity = w.css(".entry-humidity").children.first.to_s.to_f
          # puts humidity.inspect

          h = {
            :time_created => Time.now,
            :time_from => time_from,
            :time_to => time_from + 3600,
            :temperature => temp,
            :feel_temperature => feel_temp,
            #  :pressure => pressures[0][0].to_f,
            :wind_kmh => wind,
            :wind => wind / 3.6,
            #  :snow => nil, #snows[0][0].to_f,
            :rain => rain,
            :cloud_cover => cloud_cover,
            :humidity => humidity,
            :provider => self.class.provider_name
          }

          data << h
        end

      end

      return data
    end
  end
end
