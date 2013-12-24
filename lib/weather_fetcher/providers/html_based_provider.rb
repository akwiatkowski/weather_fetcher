require 'net/http'
require 'curb'

# All ugly providers who parse even uglier html code and rip off data
module WeatherFetcher
  class HtmlBasedProvider < Provider

    TYPE = :html_based
    USER_AGENT = "Chrome 32.0.1667.0"

    # Get processed weather for one definition
    def fetch_and_process_single(p)
      return nil unless can_fetch?(p)

      @pre_download = Time.now
      body = fetch_url(url(p))
      @pre_process = Time.now
      processed = process(body)
      @post_process = Time.now
      store_time_costs(processed)
      store_city_definition(processed, p)

      return processed
    end

    # Download url
    def fetch_url_old(url)
      s = Net::HTTP.get2(URI.parse(url), { 'User-Agent' => USERAGENT })
      puts s.inspect, url
      return s
    end

    def fetch_url(url)
      http = Curl::Easy.perform(url) do |curl|
        curl.headers["User-Agent"] = USER_AGENT
        curl.enable_cookies = true
        curl.follow_location = true
      end
      s = http.body_str
      return s
    end

    # Url for current provider
    def url(p)
      provider_params(p)[:url]
    end

    def can_fetch?(p)
      begin
        url(p).nil? == false
      rescue
        false
      end
    end

    # How often weather is updated
    def self.weather_updated_every
      4*HOUR
    end

  end
end