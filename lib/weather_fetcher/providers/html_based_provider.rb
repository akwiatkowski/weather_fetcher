require 'net/http'

# All ugly providers who parse even uglier html code and rip off data
module WeatherFetcher
  class HtmlBasedProvider < Provider

    TYPE = :html_based

    # Get processed weather for one definition
    def fetch_and_process_single(p)
      return nil unless can_fetch?(p)

      @pre_download = Time.now
      body = fetch_url(url(p))
      @pre_process = Time.now
      processed = process(body)
      @post_process = Time.now
      store_time_costs(processed)

      return processed
    end

    # Download url
    def fetch_url(url)
      return Net::HTTP.get(URI.parse(url))
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