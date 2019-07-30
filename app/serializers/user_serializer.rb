class UserSerializer
  def initialize(user)
    @user = user
  end

  def get_api_key
    {
      api_key: @user.api_key
    }
  end
end
