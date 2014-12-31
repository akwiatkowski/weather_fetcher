require 'logger'
require 'colorize'

# Fetcher
module WeatherFetcher
  class Fetcher

    attr_accessor :logger

    def initialize
      @logger = Logger.new(STDOUT)
    end

    def fetch(defs, max_response_time = 0.8)
      require 'yaml'
      classes = ProviderList.providers(max_response_time)
      result = Array.new

      classes.each do |c|
        self.logger.debug("#{self.class.to_s.blue} - starting #{c.to_s.red} with #{defs.size.to_s.green} definitions")

        instance = c.new(defs)
        instance.logger = self.logger
        instance.fetch
        class_results = instance.weathers

        self.logger.debug("#{self.class.to_s.blue} - done #{c.to_s.red} with #{class_results.size.to_s.green} results")
        result += class_results
      end

      return result
    end

    def represent_result(result)
      puts result.inspect
      data = result.sort{|r,s| r.time_from <=> s.time_from}
      data.each do |d|
        puts "#{d.provider} #{d.time_from} #{d.temperature} #{d.wind}"
      end
    end

  end
end