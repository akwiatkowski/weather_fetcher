# encoding: utf-8

require 'spec_helper'

describe WeatherFetcher do
  context 'fetch from websites' do
    before :each do
      @defs = load_fixture('main')
      @defs.size.should > 0
    end

    it "should fetch using all classes separately" do
      klasses = WeatherFetcher::ProviderList.providers
      klasses.each do |k|
        begin
          instance = k.new(@defs)
          weathers = instance.fetch
        rescue => e
          puts "failed at model #{k}"
          raise e
        end
      end
    end

    it "should fetch using main class" do
      result = WeatherFetcher::Fetcher.fetch(@defs)
      result.size.should > 1
    end

  end

  it "use one method to fetch from all providers" do
    #result = WeatherFetcher::Fetcher.fetch(h)
    #WeatherFetcher::Fetcher.represent_result(result)
  end


end