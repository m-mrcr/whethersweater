class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render status: 201, json: UserSerializer.new(user).get_api_key
    else
      render status: :bad_request, json: { error: user.errors.full_messages.join('. ') }
    end
  end
end

private

   def user_params
     params.require(:user).permit(:email, :password)
   end
