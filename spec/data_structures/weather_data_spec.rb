# encoding: utf-8

require 'spec_helper'

describe WeatherFetcher::WeatherData do
  before :each do
    @h = {
      :temperature => 1.0,
      :wind => 2.0,
      :time_from => Time.now - 30*60,
      :time_to => Time.now,
    }
  end

  it "should create using initialize" do
    @w = WeatherFetcher::WeatherData.new(@h)

    expect(@w.time_from).to eq(@h[:time_from])
    expect(@w.time_to).to eq(@h[:time_to])
    expect(@w.temperature).to eq(@h[:temperature])
    expect(@w.wind).to eq(@h[:wind])
  end

  it "should create using factory of Hash object" do
    @ws = WeatherFetcher::WeatherData.factory(@h)
    @w = @ws.first

    expect(@w.time_from).to eq(@h[:time_from])
    expect(@w.time_to).to eq(@h[:time_to])
    expect(@w.temperature).to eq(@h[:temperature])
    expect(@w.wind).to eq(@h[:wind])
  end

  it "should create using factory of Array object" do
    @a = [@h]
    @ws = WeatherFetcher::WeatherData.factory(@a)
    @w = @ws.first

    expect(@w.time_from).to eq(@h[:time_from])
    expect(@w.time_to).to eq(@h[:time_to])
    expect(@w.temperature).to eq(@h[:temperature])
    expect(@w.wind).to eq(@h[:wind])
  end
end