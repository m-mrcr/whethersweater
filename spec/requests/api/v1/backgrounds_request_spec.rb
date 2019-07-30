require 'rails_helper'

RSpec.describe 'Forecast' do
    before(:each) do
      VCR.use_cassette('requests/api/v1/background_response') do
        get '/api/v1/background?location=denver,co'
      end
    end

    it "response is successful" do
      expect(response).to be_successful
    end

    it "response is a URL" do
      expect(response.body.class).to eq(String)
    end
  end
