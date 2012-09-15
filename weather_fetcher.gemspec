# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "weather_fetcher"
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aleksander Kwiatkowski"]
  s.date = "2012-09-15"
  s.description = "Fetch weather from various Polish websites and via other gems. At the moment it is only polish portal Onet.pl but more providers will come soon."
  s.email = "bobikx@poczta.fm"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/weather_fetcher.rb",
    "lib/weather_fetcher/fetcher.rb",
    "lib/weather_fetcher/provider_list.rb",
    "lib/weather_fetcher/providers.rb",
    "lib/weather_fetcher/providers/html_based/interia_pl.rb",
    "lib/weather_fetcher/providers/html_based/onet_pl.rb",
    "lib/weather_fetcher/providers/html_based/world_weather_online.rb",
    "lib/weather_fetcher/providers/html_based/wp_pl.rb",
    "lib/weather_fetcher/providers/html_based_provider.rb",
    "lib/weather_fetcher/providers/metar/all_met_sat.rb",
    "lib/weather_fetcher/providers/metar/aviation_weather.rb",
    "lib/weather_fetcher/providers/metar/noaa.rb",
    "lib/weather_fetcher/providers/metar/wunderground.rb",
    "lib/weather_fetcher/providers/metar_provider.rb",
    "lib/weather_fetcher/providers/provider.rb",
    "lib/weather_fetcher/scheduler_helper.rb",
    "lib/weather_fetcher/server.rb",
    "lib/weather_fetcher/utils/time.rb",
    "lib/weather_fetcher/weather_data.rb"
  ]
  s.homepage = "http://github.com/akwiatkowski/weather_fetcher"
  s.licenses = ["LGPLv3"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Fetch weather from various Polish websites and via other gems"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<simple_metar_parser>, [">= 0.0.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
    else
      s.add_dependency(%q<simple_metar_parser>, [">= 0.0.1"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
    end
  else
    s.add_dependency(%q<simple_metar_parser>, [">= 0.0.1"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
  end
end

