require 'net/http'

# All ugly providers who parse even uglier html code and rip off data
module WeatherFetcher
  class HtmlBasedProvider < Provider

    TYPE = :html_based

    # Get processed weather for one definition
    def fetch_and_process_single(p)
      return nil unless can_fetch?(p)
      
      body = fetch_url(url(p))
      processed = process(body)
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

  end
end