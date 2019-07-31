require 'rails_helper'

RSpec.describe 'Forecast' do
  before(:each) do
    VCR.use_cassette('requests/api/v1/forecast_response') do
      get '/api/v1/forecast?location=denver,co'
    end
    @full_response = JSON.parse(response.body, symbolize_names: true)
  end

  it "response is successful" do
    expect(response).to be_successful
  end

  it "knows about city" do
    address = @full_response[:location_data][:results].first[:formatted_address]

    expect(address).to eq("Denver, CO, USA")
  end

  it "has current temperature" do
    current_temp = @full_response[:forecast_data][:currently][:temperature]

    expect(current_temp.class).to eq(Float)
  end
end
