require 'rails_helper'

describe 'Unsplash' do
  before(:each) do
    VCR.use_cassette('/services/unsplash_service') do
      @location = 'denver, co'
      @service = Unsplash.new.image(@location)
    end
  end

  it "initializes with location" do
    expect(@service.class).to eq(String)
  end
end
