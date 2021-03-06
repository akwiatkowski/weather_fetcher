# Fetcher
module WeatherFetcher
  class WeatherData

    attr_accessor :time_costs

    def initialize(h = { })
      @time_costs = Hash.new
      @h = h
      @h.keys.each do |k|
        self.instance_variable_set("@#{k}".to_sym, @h[k])
      end
    end

    # Return Array of WeatherData objects
    def self.factory(obj)
      return [ new(obj) ] if obj.kind_of? Hash
      return factory_from_array(obj) if obj.kind_of? Array
    end

    def self.factory_from_array(array = [])
      ao = Array.new
      array.each do |a|
        obj = self.new(a)
        ao << obj
      end
      return ao
    end

    # Mark this weather as just downloaded
    def just_fetched!
      @fetch_time ||= Time.now
    end

    def next_within!(_interval)
      # just_fetched!
      @next_fetch_time = @fetch_time + _interval
    end

    def is_metar?
      self.provider == WeatherFetcher::MetarProvider.provider_name
    end

    def city
      return nil? if @city_hash.nil?
      @city_hash[:name]
    end

    attr_reader :time_created, :time_from, :time_to, :fetch_time, :next_fetch_time,
      :temperature, :wind, :pressure, :wind_kmh, :snow, :rain,
      :rain_metar, :snow_metar,
      :cloud_cover, :humidity, :visibility, # available in WorldWeatherOnline
      :provider,
      :metar_string

    attr_accessor :city_hash



  end
end