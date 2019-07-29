require 'rails_helper'

RSpec.describe 'DarkSky' do
  before(:each) do
    @coordinates = {latitude:'39.7392', longitude:'-104.9849'}
    @service = DarkSky.new(@coordinates)
  end

  it "initializes with coordinates" do
    expect(@service.latitude).to eq(@coordinates[:latitude])
    expect(@service.longitude).to eq(@coordinates[:longitude])
  end

  it '#forecast returns forecasted data' do
    result = @service.forecast

    expect(result).to have_key(:offset)

    expect(result[:currently]).to have_key(:time)
    expect(result[:currently]).to have_key(:summary)
    expect(result[:currently]).to have_key(:icon)
    expect(result[:currently]).to have_key(:temperature)
    expect(result[:currently]).to have_key(:apparentTemperature)
    expect(result[:currently]).to have_key(:humidity)
    expect(result[:currently]).to have_key(:visibility)
    expect(result[:currently]).to have_key(:uvIndex)

    expect(result[:hourly][:data].count).to be >= 8
    expect(result[:hourly][:data].first).to have_key(:time)
    expect(result[:hourly][:data].first).to have_key(:icon)
    expect(result[:hourly][:data].first).to have_key(:temperature)

    expect(result[:daily][:data].count).to be >= 5
    expect(result[:daily][:data].first).to have_key(:time)
    expect(result[:daily][:data].first).to have_key(:icon)
    expect(result[:daily][:data].first).to have_key(:summary)
    expect(result[:daily][:data].first).to have_key(:precipType)
    expect(result[:daily][:data].first).to have_key(:precipProbability)
    expect(result[:daily][:data].first).to have_key(:temperatureHigh)
    expect(result[:daily][:data].first).to have_key(:temperatureLow)
  end
end
