require 'rails_helper'

describe 'GoogleMaps' do
  before(:each) do
    @location = 'denver, co'
    @origin = '3301 E 14th Ave, Denver, CO 80206, USA'
    @destination = '1331 17th St, Denver, CO 80202, USA'
    VCR.use_cassette('/services/google_maps_service') do
      @service = GoogleMaps.new({ location: @location,
                                  origin: @origin,
                                  destination: @destination
                                })
    end
  end

  it "initializes with location" do
    expect(@service.location).to eq(@location)
  end

  it "#geocoding_response returns formatted location, latitude & longitude" do
    result = @service.geocoding_response

    expect(result).to have_key(:results)
    expect(result[:results].first).to have_key(:formatted_address)
    expect(result[:results].first[:geometry][:location]).to have_key(:lat)
    expect(result[:results].first[:geometry][:location]).to have_key(:lng)
  end

  it "#directions_response returns information about trip" do
    result = @service.directions_response
    start_point = result[:routes].first[:legs].first[:start_address]
    end_point = result[:routes].first[:legs].first[:end_address]
    
    expect(result).to have_key(:routes)
    expect(start_point).to eq(@origin)
    expect(end_point).to eq(@destination)
  end
end
