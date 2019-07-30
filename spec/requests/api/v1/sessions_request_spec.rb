require 'rails_helper'

RSpec.describe 'Session' do
  describe "when a user logs in" do
    before(:each) do
      @user = create(:user,
                    email: 'user@example.com',
                    password: 'password')
      @params = {
          email: "#{@user.email}",
          password: "#{@user.password}",
      }
      post '/api/v1/sessions', params: @params
      @parsed_response = JSON.parse(response.body, symbolize_names: true)
    end

    it "response is successful" do
      expect(response).to be_successful
    end

    it "has status 200" do
      expect(response).to have_http_status(200)
    end

    it "has attributes" do
      expect(@user.api_key).to eq(@parsed_response[:api_key])
    end
  end

  describe "when a user can't log in (sad_path)" do
    before(:each) do
      @user = create(:user,
                    email: 'user@example.com',
                    password: 'password')
      @params = {
          password: "#{@user.password}"
      }
      post '/api/v1/sessions', params: @params
      @parsed_response = JSON.parse(response.body, symbolize_names: true)
    end

    it "status is unauthorized" do
      expect(response).to have_http_status(401)
    end

    it "throws an error message" do
      expect(@parsed_response).to have_key(:error)
    end
  end
end
