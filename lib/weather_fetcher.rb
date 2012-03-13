$:.unshift(File.dirname(__FILE__))

require 'weather_fetcher/utils/time'

require 'weather_fetcher/weather_data'
require 'weather_fetcher/providers'
require 'weather_fetcher/provider_list'
require 'weather_fetcher/fetcher'
require 'weather_fetcher/server'

module WeatherFetcher
end
