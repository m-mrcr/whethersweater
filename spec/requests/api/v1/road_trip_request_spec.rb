require 'rails_helper'
RSpec.describe 'Road Trip' do
  before(:each) do
    params = { "origin": "Denver,CO",
               "destination": "Pueblo,CO",
               "api_key": "jgn983hy48thw9begh98h4539h4"
             }
    # VCR.use_cassette('requests/api/v1/road_trip') do
      post '/api/v1/road_trip', params: params
      # @full_response = JSON.parse(response.body, symbolize_names: true)
    # end
  end

  it "response is successful" do
    expect(response).to be_successful
  end

end
