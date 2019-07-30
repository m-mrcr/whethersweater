require 'rails_helper'

RSpec.describe 'User' do
  describe "when a user is created" do
    before(:each) do
      @params = {
        user: {
          email: 'whatever@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }

      post '/api/v1/users', params: @params

      @user = User.last
      @parsed_response = JSON.parse(response.body, symbolize_names: true)
    end

    it "response is successful" do
      expect(response).to be_successful
    end

    it "has status 201" do
      expect(response).to have_http_status(201)
    end

    it "has attributes" do
      expect(@user.email).to eq(@params[:user][:email])
      expect(@user.api_key).to eq(@parsed_response[:api_key])
    end
  end

  describe "when a user isn't created (sad_path)" do
    before(:each) do
      @params = {
        user: {
          password: 'password',
          password_confirmation: 'password'
        }
      }
      post '/api/v1/users', params: @params
      @user = User.last
      @parsed_response = JSON.parse(response.body, symbolize_names: true)
    end

    it "doesn't save user attributes" do
      expect(User.all).to eq([])
    end

    it "throws an error message" do
      expect(@parsed_response).to have_key(:error)
    end
  end
end
