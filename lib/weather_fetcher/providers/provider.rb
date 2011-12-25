# Base class for ordinary weather provider
module WeatherFetcher
  class Provider
    # kind of provider: standard, html (self web based), gem (other gem)
    TYPE = :standard

    # Create an instance, definitions can be set here
    def initialize(_defs = Array.new)
      @weathers = Array.new
      self.defs= _defs
    end

    attr_reader :weathers

    # Definitions, format like below
    #- :url: 'http://pogoda.onet.pl/0,846,38,,,inowroclaw,miasto.html'
    #  :city: 'Inowrocław'
    #  :country: 'Poland'
    #  :coord:
    #    :lat: 52.799264
    #    :lon: 18.259935

    attr_reader :defs

    def defs=(_defs)
      if _defs.kind_of? Hash
        @defs = [_defs]
      elsif _defs.kind_of? Array
        @defs = _defs
      else
        raise 'Wrong definitions type'
      end
    end

    # Name of provider
    def provider_name
      self.class.provider_name
    end

    # Name of provider, should be overrode
    def self.provider_name
      raise 'Not implemented'
    end

    # Fetch everything from definitions (defs)
    def fetch
      a = Array.new
      defs.each do |d|
        a += fetch_and_process_single(d)
      end
      return a
    end

    # Fetch single definition
    def fetch_and_process_single(d)
      url = d[:url]
      body = fetch_url(url)
      processed = process(body)
      return processed
    end


  end
end