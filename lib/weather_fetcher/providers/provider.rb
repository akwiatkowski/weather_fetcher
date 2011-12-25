module WeatherFetcher
  class Provider


    TYPE = :standard

    attr_accessor :defs

    def initialize(_defs = Array.new)
      @weathers = Array.new
      @defs = _defs
    end

    def provider_name
      self.class.provider_name
    end

    def self.provider_name
      raise 'Not implemented'
    end

    def fetch
      a = Array.new
      defs.each do |d|
        a += fetch_single(d)
      end
      return a
    end

    # Fetch
    def fetch_single
      body = fetch_url(definition)
      processed = process(body)
      weathers = Weather.create_from(processed, definition)

      #puts weathers.inspect
      weathers.each do |w|
        w.store
      end

      return weathers
    end


  end
end