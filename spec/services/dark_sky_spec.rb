require 'rails_helper'

RSpec.describe 'DarkSky' do
  before(:each) do
    @coordinates = {lat:39.7392358, lng:-104.990251}
    @service = DarkSky.new(@coordinates)
    VCR.use_cassette('/services/dark_sky_service') do
      @forecast = @service.forecast
    end
  end

  it "initializes with coordinates" do
    expect(@service.latitude).to eq(@coordinates[:lat])
    expect(@service.longitude).to eq(@coordinates[:lng])
  end

  it '#forecast returns forecasted data' do
    expect(@forecast).to have_key(:offset)

    expect(@forecast[:currently]).to have_key(:time)
    expect(@forecast[:currently]).to have_key(:summary)
    expect(@forecast[:currently]).to have_key(:icon)
    expect(@forecast[:currently]).to have_key(:temperature)
    expect(@forecast[:currently]).to have_key(:apparentTemperature)
    expect(@forecast[:currently]).to have_key(:humidity)
    expect(@forecast[:currently]).to have_key(:visibility)
    expect(@forecast[:currently]).to have_key(:uvIndex)

    expect(@forecast[:hourly][:data].count).to be >= 8
    expect(@forecast[:hourly][:data].first).to have_key(:time)
    expect(@forecast[:hourly][:data].first).to have_key(:icon)
    expect(@forecast[:hourly][:data].first).to have_key(:temperature)

    expect(@forecast[:daily][:data].count).to be >= 5
    expect(@forecast[:daily][:data].first).to have_key(:time)
    expect(@forecast[:daily][:data].first).to have_key(:icon)
    expect(@forecast[:daily][:data].first).to have_key(:summary)
    expect(@forecast[:daily][:data].first).to have_key(:precipType)
    expect(@forecast[:daily][:data].first).to have_key(:precipProbability)
    expect(@forecast[:daily][:data].first).to have_key(:temperatureHigh)
    expect(@forecast[:daily][:data].first).to have_key(:temperatureLow)
  end
end
