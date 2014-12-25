require 'spec_helper'

describe WeatherFetcher do
  it "simple stuff" do
    expect(WeatherFetcher.class).to eq(Module)
  end

  it "should accept only Array or Hash definitions" do
    expect { WeatherFetcher::Provider.new("ble") }.to raise_error
    expect { WeatherFetcher::Provider.new(1) }.to raise_error
    expect { WeatherFetcher::Provider.new() }.not_to raise_error
    expect { WeatherFetcher::Provider.new([]) }.not_to raise_error
    expect { WeatherFetcher::Provider.new({}) }.not_to raise_error
  end

  it "should return provider classes list" do
    providers = WeatherFetcher::ProviderList.providers
    providers.each do |p|
      expect(p).to be_kind_of(Class)

      instance = p.new
      expect(instance).to respond_to(:fetch)
    end
  end

end
