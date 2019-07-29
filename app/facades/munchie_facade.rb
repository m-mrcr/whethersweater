class MunchieFacade
  def initialize(input)
    binding.pry
    @start = input[:start]
    @end = input[:end]
    @food = input[:food]
  end

  def get_restaurants
    params = {
      term: @food,
      location: @end,
      open_at: 
    }
    get_json('/v3/businesses/search', params)
  end

  def get_json(uri, params = {})
    response = conn.get uri, params
    JSON.parse response.body, symbolize_names: true
  end

  def conn
    Faraday.new('https://api.yelp.com') do |f|
      f.adapter Faraday.default_adapter
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end
end
