module WeatherFetcher
  class ProviderList
    def self.providers(speed = 0.7)
      classes = WeatherFetcher::Provider.constants
      classes = classes.collect{|c| WeatherFetcher::Provider.const_get c}.select{|c| c.kind_of? Class}
      classes.select{|k| not defined? k::SLOW or k::SLOW <= speed}
    end
  end
end
