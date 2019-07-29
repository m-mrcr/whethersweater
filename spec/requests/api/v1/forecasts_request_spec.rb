require 'rails_helper'

RSpec.describe 'Forecast' do
  VCR.use_cassette('requests/api/v1/forecast_response') do
    before(:each) do
      get '/api/v1/forecast?location=denver,co'
    end

    it "response is successful" do
      expect(response).to be_successful
    end

    it "knows about city" do
      full_response = JSON.parse(response.body, symbolize_names: true)

      address = full_response[:google_results][:results].first[:formatted_address]

      expect(address).to eq("Denver, CO, USA")
    end

    it "has current temperature" do
      full_response = JSON.parse(response.body, symbolize_names: true)

      current_temp = full_response[:forecast_data][:currently][:temperature]

      expect(current_temp.class).to eq(Float)
    end
  end
end
