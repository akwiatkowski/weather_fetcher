# Fetcher
module WeatherFetcher
  class Fetcher

    def self.fetch(p)
      require 'yaml'
      classes = ProviderList.providers
      result = Array.new
      # puts p.to_yaml

      classes.each do |c|
        # puts "executing #{c.to_s}"
        instance = c.new(p)
        instance.fetch
        result += instance.weathers
      end

      return result
    end

    def self.represent_result(result)
      puts result.inspect
      data = result.sort{|r,s| r.time_from <=> s.time_from}
      data.each do |d|
        puts "#{d.time_from} #{d.temperature} #{d.wind}"
      end
    end

  end
end