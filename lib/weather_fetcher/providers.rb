$:.unshift(File.dirname(__FILE__))

require 'providers/provider'

require 'providers/html_based_provider'
require 'providers/html_based/onet_pl'
require 'providers/html_based/interia_pl'
require 'providers/html_based/wp_pl'
require 'providers/html_based/twoja_pogoda_pl'
require 'providers/html_based/world_weather_online'

require 'providers/metar_provider'
require 'providers/metar/noaa'
require 'providers/metar/all_met_sat'
require 'providers/metar/aviation_weather'
require 'providers/metar/wunderground'