require 'rails_helper'

RSpec.describe 'Forecast' do
  before(:each) do
    get '/api/v1/forecast?location=denver,co'
  end

  it "response is successful" do
    expect(response).to be_successful
  end

end
