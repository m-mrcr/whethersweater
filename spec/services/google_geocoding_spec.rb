require 'rails_helper'

describe 'GoogleGeocoding' do
  VCR.use_cassette('')
  before(:each) do
    @location = 'denver, co'
    @origin = '3301 E 14th Ave, Denver, CO 80206, USA'
    @destination = '1331 17th St, Denver, CO 80202, USA'
    @service = GoogleGeocoding.new({ location: @location,
                                     start: @origin,
                                     end: @destination
                                    })
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

  it "#trip_results returns information about trip" do
    result = @service.trip_results
    start_point = result[:routes].first[:legs].first[:start_address]
    end_point = result[:routes].first[:legs].first[:end_address]

    expect(result).to have_key(:routes)
    expect(start_point).to eq(@origin)
    expect(end_point).to eq(@destination)
  end
end
