require 'net/http'

# All ugly providers who parse even uglier html code and rip off data
module WeatherFetcher
  class HtmlBasedProvider < Provider

    TYPE = :html_based

    # Get processed weather for one definition
    def fetch_and_process_single(d)
      url = d[:url]
      body = fetch_url(url)
      processed = process(body)
      return processed
    end

    # Download url
    def fetch_url(url)
      return Net::HTTP.get(URI.parse(url))
    end

  end
end