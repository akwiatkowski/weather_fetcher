#encoding: utf-8

require 'nokogiri'
require 'time'

module WeatherFetcher
  class Provider::TwojaPogodaPl < HtmlBasedProvider

    def self.provider_name
      "TwojaPogoda.pl"
    end

    def process(string)
      return WeatherData.factory(_process(string))
    end

    # Process response body and rip out weather data
    def _process(body_raw)
      data = Array.new
      b = Nokogiri::HTML(body_raw)

      dates = b.css("table.items > tr > th > small")
      dates = dates.collect { |d| Time.parse(d.children.first.to_s) }

      temperatures = Array.new
      winds = Array.new
      clouds = Array.new
      feel_temps = Array.new
      humids = Array.new
      pressures = Array.new
      precips = Array.new

      rows = b.css("table.items > tr")
      rows.each do |row|
        tags = row.css("td > div")
        tags.each_with_index do |tag, i|
          if tag.attribute("class").to_s == "info"
            temperatures << tag.css("strong").children.first.to_s.to_f
          end

          if tag.children.first.to_s == "Wiatr"
            wind = tags[i + 1].children.first.to_s.to_f
            winds << wind
          end

          if tag.children.first.to_s == "Chmury"
            cloud = tags[i + 1].children.first.to_s
            if cloud =~ /(\d{1,2})-(\d{1,2})/
              cloud = ($1.to_i + $2.to_i) / 2
            elsif cloud =~ /(\d{1,2}) /
              cloud = $1.to_i
            else
              cloud = nil
            end
            clouds << cloud
          end

          if tag.children.first.to_s == "T.odczuw."
            feel_temp = tags[i + 1].children.first.to_s.to_f
            feel_temps << feel_temp
          end

          if tag.children.first.to_s == "Wilgotność"
            humid = tags[i + 1].children.first.to_s.to_f
            humids << humid
          end

          if tag.children.first.to_s == "Ciśnienie"
            pressure = tags[i + 1].children.first.to_s.to_f
            pressures << pressure
          end

          if tag.children.first.to_s == "Opady"
            precip = tags[i + 1].children.first.to_s
            if precip =~ /(\d{1,2}\.?\d{1,2})/
              precip = $1.to_f
            else
              precip = nil
            end
            precips << precip
          end

        end
      end

      dates.each_with_index do |d, i|
        data << {
          :time_created => Time.now,
          :time_from => d,
          :time_to => d + 24*3600,
          :temperature => temperatures[i],
          :feel_temperature => feel_temps[i],
          :pressure => pressures[i],
          :wind_kmh => winds[i],
          :wind => winds[i] / 3.6,
          #  :snow => nil, #snows[0][0].to_f,
          :rain => precips[i],
          :cloud_cover => clouds[i],
          :humidity => humids[i],
          :provider => self.class.provider_name
        }
      end

      # puts data.inspect

      return data
    end


  end

end
