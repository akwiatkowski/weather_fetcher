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
        ao << self.new(a)
      end
      return ao
    end

    attr_reader :temperature, :wind

  end
end