require 'rails_helper'

describe 'GoogleMaps' do
  before(:each) do
    # VCR.use_cassette('/services/google_maps_service') do
      @location = 'denver, co'
      @service = GoogleMaps.new({ location: @location })
    # end
  end

  it "initializes with location" do
    expect(@service.location).to eq(@location)
  end

  it "#results returns formatted location and latitude / longitude" do
    result = @service.results

    expect(result).to have_key(:results)
    expect(result[:results].first).to have_key(:formatted_address)
    expect(result[:results].first[:geometry][:location]).to have_key(:lat)
    expect(result[:results].first[:geometry][:location]).to have_key(:lng)
  end
end
