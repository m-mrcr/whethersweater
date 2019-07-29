require 'rails_helper'

RSpec.describe 'Munchies' do
  # VCR.use_cassette('requests/api/v1/background_response') do
    before(:each) do
      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese Content-Type: application/json Accept: application/jsons'
    end

    it "response is successful" do
      expect(response).to be_successful
    end

end
