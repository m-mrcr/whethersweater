require 'rails_helper'
RSpec.describe 'Road Trip' do
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
    # VCR.use_cassette('requests/api/v1/road_trip') do
      post '/api/v1/road_trip', params: @params
      # @full_response = JSON.parse(response.body, symbolize_names: true)
    # end
  end

  it "response is successful" do
    expect(response).to be_successful
  end

end
