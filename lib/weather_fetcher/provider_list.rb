module WeatherFetcher
  class ProviderList
    def self.providers
      classes = WeatherFetcher::Provider.constants
      classes.collect{|c| WeatherFetcher::Provider.const_get c}.select{|c| c.kind_of? Class}
    end

  end
end
