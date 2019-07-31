require 'rails_helper'

RSpec.describe Restaurant do
  before(:each) do
    @params = {
      name: 'Slice Works',
      location:
      {
        display_address: ['1433 17th St Suite 100', 'Denver, CO 80202']
        }
    }
    @restaurant = Restaurant.new(@params)
  end

  it "has attributes" do
    expect(@restaurant.name).to eq(@params[:name])
    expect(@restaurant.address).to eq('1433 17th St Suite 100, Denver, CO 80202')
  end
end
