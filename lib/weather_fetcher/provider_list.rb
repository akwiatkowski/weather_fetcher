module WeatherFetcher
  class ProviderList
    def self.providers
      classes = WeatherFetcher::Provider.constants - ['TYPE']
      classes.collect{|c| WeatherFetcher::Provider.const_get c}
    end

  end
end
