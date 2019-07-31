require 'rails_helper'
RSpec.describe 'Munchies' do
  before(:each) do
      @time_now = Time.parse("2019-07-30 15:00 -06:00")
      allow(Time).to receive(:now).and_return(@time_now)
      VCR.use_cassette('requests/api/v1/munchies_response') do
        get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
      end
      @full_response = JSON.parse(response.body, symbolize_names: true)
  end

  it "response is successful" do
    expect(response).to be_successful
  end

  it "should know about the destination" do
    expect(@full_response[:destination]).to eq('pueblo,co')
  end

  it "should have three restaurants" do
    expect(@full_response[:restaurants].count).to eq(3)
    expect(@full_response[:restaurants].first[:name].class).to eq(String)
    expect(@full_response[:restaurants].first[:address].class).to eq(String)
  end
end
