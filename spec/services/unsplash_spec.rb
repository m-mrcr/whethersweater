require 'rails_helper'

describe 'Unsplash' do
  before(:each) do
    @location = 'denver, co'
    @service = Unsplash.new.image(@location)
  end

  it "initializes with location" do
binding.pry
    expect(@service).to
  end

  xit "#results returns formatted location and latitude / longitude" do
    result = @service.results

    expect(result).to have_key(:results)
    expect(result[:results].first).to have_key(:formatted_address)
    expect(result[:results].first[:geometry][:location]).to have_key(:lat)
    expect(result[:results].first[:geometry][:location]).to have_key(:lng)
  end
end
