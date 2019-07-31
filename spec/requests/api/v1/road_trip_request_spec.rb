require 'rails_helper'
RSpec.describe 'Road Trip' do
  describe "when user has valid api_key" do
    before(:each) do
      user = create(:user)
      @api_key = user.api_key
      @params = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": @api_key
      }
      @headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      VCR.use_cassette('requests/api/v1/road_trip_response') do
        post '/api/v1/road_trip', params: @params
        @full_response = JSON.parse(response.body, symbolize_names: true)
      end
    end

    it "response is successful" do
      expect(response).to be_successful
    end

    it "response meets requirements" do
      expect(@full_response).to have_key(:travel_time)
      expect(@full_response).to have_key(:temperature)
      expect(@full_response).to have_key(:summary)
    end
  end

  describe "when user doesn't have valid api_key" do
    before(:each) do
      user = create(:user)
      @api_key = user.api_key
      @params = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "0192837401872364iuy"
      }
      @headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      VCR.use_cassette('requests/api/v1/road_trip_sad_path_response') do
        post '/api/v1/road_trip', params: @params
      end
        @full_response = JSON.parse(response.body, symbolize_names: true)
    end

    it "has status 'unauthorized'" do
      expect(response).to have_http_status(401)
    end

    it "displays error" do
      expect(@full_response).to have_key(:error)
    end
  end
end
