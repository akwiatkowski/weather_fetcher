# Fetcher
module WeatherFetcher
  class Fetcher

    def self.fetch(p, max_response_time = 0.8)
      require 'yaml'
      classes = ProviderList.providers(max_response_time)
      result = Array.new

      classes.each do |c|
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