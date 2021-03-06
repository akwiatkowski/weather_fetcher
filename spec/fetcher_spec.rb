# encoding: utf-8

require 'spec_helper'

describe WeatherFetcher do
  context 'fetch from websites' do
    before :each do
      @defs = load_fixture('main')
      expect(@defs.size).to be > 0
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
      result = WeatherFetcher::Fetcher.new.fetch(@defs)
      expect(result.size).to be > 1
    end

    it "use one method to fetch from all providers" do
      wf = WeatherFetcher::Fetcher.new
      result = wf.fetch(@defs)
      # wf.represent_result(result)
    end

  end

end