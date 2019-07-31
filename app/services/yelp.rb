class Yelp < Base
  def initialize(attributes)
    @location = attributes[:location]
    @food_term = attributes[:food]
    @arrival_time = attributes[:arrival_time]
  end

  def get_restaurants
    params = {
      location: @location,
      open_at: @arrival_time,
      categories: 'food',
      term: @food_term,
      limit: 3,
    }
    get_json('/v3/businesses/search', params)[:businesses]
  end

  private

  def conn
    Faraday.new('https://api.yelp.com') do |f|
      f.adapter Faraday.default_adapter
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end

end
