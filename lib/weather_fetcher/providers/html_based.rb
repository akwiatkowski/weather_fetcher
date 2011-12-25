require 'net/http'

# All ugly providers who parse even uglier html code and rip off data
module WeatherFetcher
  class HtmlBased < Provider

    TYPE = :html_based


    # Fetch
    def fetch_single(d)
      url = d[:url]
      body = fetch_url(url)
      processed = process(body)
      return processed
    end

    def fetch_url(url)
      return Net::HTTP.get(URI.parse(url))
    end


  end
end