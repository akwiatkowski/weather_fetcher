# Fetcher
module WeatherFetcher
  class WeatherData

    def initialize(h = {})
      @h = h
      @h.keys.each do |k|
        self.instance_variable_set("@#{k}".to_sym, @h[k])
        #send :attr_accessor, k
      end
    end

    def self.factory(array = [])
      ao = Array.new
      array.each do |a|
        obj = self.new(a)
        puts obj.time_from
        ao << obj
      end
      return ao
    end

    attr_reader :temperature, :wind, :time_from, :time_to

  end
end