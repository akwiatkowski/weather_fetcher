# Fetcher
module WeatherFetcher
  class Fetcher

    def self.fetch(p)
      require 'yaml'
      classes = ProviderList.providers

      #puts classes.collect{|c| c.to_s}.to_yaml
      #puts "*"*200
      puts p.to_yaml

      classes.each do |c|
        puts "executing #{c.to_s}"
        instance = c.new(p)
        puts instance.fetch
      end

    end


  end
end