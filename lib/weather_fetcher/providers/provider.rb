require 'logger'
require 'colorize'

# Base class for ordinary weather provider
module WeatherFetcher
  class Provider
    # kind of provider: standard, html (self web based), gem (other gem)
    TYPE = :standard

    # just a constant, seconds in 1 hour
    HOUR = 3600

    # Create an instance, definitions can be set here
    def initialize(_defs = Array.new)
      @weathers = Array.new
      @logger = Logger.new(STDOUT)
      self.defs = _defs
    end

    attr_reader :weathers
    attr_reader :defs
    attr_accessor :logger

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
      raise NotImplementedError
    end

    # Fetch everything from definitions (defs)
    def fetch(ignore_errors: true)
      self.logger.debug "#{self.class.to_s.blue} - #{defs.size.to_s.green} definitions to process"
      a = Array.new
      defs.each do |d|
        begin
          self.logger.debug "#{self.class.to_s.blue} - #{d[:name].to_s.yellow}"

          p = fetch_and_process_single(d)
          p = [] if p.nil?
          p.each do |pw|
            pw.just_fetched!
            pw.next_within!(self.class.weather_updated_every)
          end

        rescue => e
          if ignore_errors
            self.logger.error "#{self.class.to_s.blue} - #{d.inspect} fail"
            self.logger.error e.inspect
            self.logger.error e.backtrace
          else
            raise e
          end

        end
        a += p unless p.nil?
      end
      # add to result array
      @weathers += a

      return a
    end

    # Fetch single definition
    def fetch_and_process_single(d)
      return nil unless can_fetch?

      @pre_download = Time.now
      body = fetch_url(url(d))
      @pre_process = Time.now
      processed = process(body)
      @post_process = Time.now
      store_time_costs(processed)
      store_city_definition(processed, d)

      return processed
    end

    # All parameters are available and we can fetch
    def can_fetch?(p = nil)
      raise NotImplementedError
    end

    def url(p = nil)
      raise NotImplementedError
    end

    def unix_time_today
      Time.mktime(
        Time.now.year,
        Time.now.month,
        Time.now.day,
        0, 0, 0, 0)
    end

    def self.short_class_name
      self.to_s.gsub(/^.*::/, '')
    end

    def short_class_name
      self.class.short_class_name
    end

    # Return Hash of parameters used for current provider
    def provider_params(p)
      return p[:classes][short_class_name]
    end

    def store_time_costs(_processed)
      return unless _processed.kind_of?(Array)
      _processed.each do |p|
        p.time_costs[:download_time] = @pre_process - @pre_download
        p.time_costs[:process_time] = @post_process - @pre_process
      end
    end

    def store_city_definition(_processed, _city_def)
      return unless _processed.kind_of?(Array)
      _processed.each do |p|
        p.city_hash = _city_def
      end
    end

  end
end