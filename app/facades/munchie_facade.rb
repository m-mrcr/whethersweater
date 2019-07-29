class MunchieFacade
  def initialize(input)
    @start = input[:start]
    @end = input[:end]
    @food = input[:food]
  end

  def full_response
    params = {
      destination: @end,
      restaurants: processed_restaurants,
    }
  end

  private

  def processed_restaurants
    restaurants = {}
    get_restaurants.each do |r|
      name = r[:name]
      street = r[:location][:display_address].first
      city = r[:location][:display_address].second
      address = street + ", " + city
      restaurants["#{name}"] = address
    end
    restaurants
  end

  def get_restaurants
    params = {
      term: @food,
      location: @end,
      open_at: (Time.now + trip.trip_duration.seconds).to_i,
      limit: 3
    }
    get_json('/v3/businesses/search', params)[:businesses]
  end

  def trip
    params = {
      start: @start,
      end: @end
    }
    @trip ||= GoogleGeocoding.new(params)
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
