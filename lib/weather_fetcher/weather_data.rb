# Fetcher
module WeatherFetcher
  class WeatherData

    # TODO move to other gem

    def initialize(h = { })
      @h = h
      @h.keys.each do |k|
        self.instance_variable_set("@#{k}".to_sym, @h[k])
        #send :attr_accessor, k
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

    attr_reader :temperature, :wind, :time_from, :time_to, :fetch_time, :next_fetch_time

  end
end