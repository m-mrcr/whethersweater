require 'rails_helper'

describe 'GoogleMaps' do
  before(:each) do
    @location = 'denver, co'
    @service = GoogleMaps.new({ location: @location })
    VCR.use_cassette('/services/google_maps_service') do
      @geocoding_response = @service.geocoding_response
    end
  end

  it "initializes with location" do
    expect(@service.location).to eq(@location)
  end

  it "#results returns formatted location and latitude / longitude" do

    expect(@geocoding_response).to have_key(:results)
    expect(@geocoding_response[:results].first).to have_key(:formatted_address)
    expect(@geocoding_response[:results].first[:geometry][:location]).to have_key(:lat)
    expect(@geocoding_response[:results].first[:geometry][:location]).to have_key(:lng)
  end
end
