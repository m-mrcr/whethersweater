require 'rails_helper'
RSpec.describe Forecast do
  before(:each) do
    @coordinates = {
      lat: 39.742043,
      lng: -104.991531
    }
    @data = DarkSky.new(@coordinates).forecast
    @forecast = Forecast.new(@data)
  end

  it "has attributes" do
    expect(@forecast.data).to eq(@data)
  end

  it "has methods" do
    temperature = @forecast.currently[:temperature]
    expect(temperature.class).to eq(Float)

    time = @forecast.hourly.first.second[:time]
    expect(time.class).to eq(Integer)

    high = @forecast.daily.first.second[:high]
    expect(high.class).to eq(Float)
  end
end
