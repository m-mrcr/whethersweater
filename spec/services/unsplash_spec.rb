require 'rails_helper'

describe 'Unsplash' do
  before(:each) do
    @location = 'denver, co'
    @service = Unsplash.new.image(@location)
  end

  it "initializes with location" do
    expect(@service.class).to eq(String)
  end
end
