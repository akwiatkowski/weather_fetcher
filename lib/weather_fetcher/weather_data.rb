# Fetcher
module WeatherFetcher
  class WeatherData

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

    attr_reader :temperature, :wind, :time_from, :time_to

  end
end