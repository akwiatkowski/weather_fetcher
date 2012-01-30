# Fetcher
module WeatherFetcher
  class Fetcher

    def self.fetch(p)
      require 'yaml'
      puts ProviderList.providers.collect{|c| c.to_s}.to_yaml

      puts "*"*200

      puts p.to_yaml
    end


  end
end